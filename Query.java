@Autowired
private EntityManager entityManager;

public List<Audit> findWithDynamicConditions(String bookingEntityCode, String asOfDate, String extraCondition) {
    String baseQuery = "SELECT * FROM lscfr_full_stock_audit a " +
            "WHERE a.audit_info->'bookingEntityCode' LIKE :bookingEntityCode " +
            "AND a.audit_info->'asOfDate' LIKE :asOfDate ";

    if (extraCondition != null && !extraCondition.trim().isEmpty()) {
        baseQuery += "AND " + extraCondition;
    }

    Query query = entityManager.createNativeQuery(baseQuery, Audit.class);
    query.setParameter("bookingEntityCode", "%" + bookingEntityCode + "%");
    query.setParameter("asOfDate", "%" + asOfDate + "%");

    return query.getResultList();
}
