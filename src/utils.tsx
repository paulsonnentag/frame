export const SwallowPointerEvents = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  return (
    <div
      onPointerDown={(e) => e.stopPropagation()}
      onPointerUp={(e) => e.stopPropagation()}
      onPointerMove={(e) => e.stopPropagation()}
      onPointerEnter={(e) => e.stopPropagation()}
      onPointerLeave={(e) => e.stopPropagation()}
      onPointerCancel={(e) => e.stopPropagation()}
      onPointerOut={(e) => e.stopPropagation()}
      onPointerOver={(e) => e.stopPropagation()}
    >
      {children}
    </div>
  );
};

export const shouldNeverHappen = (message: string) => {
  // eslint-disable-next-line no-debugger
  debugger;
  // This function always throws an exception
  throw new Error(message);
};

export const isEmpty = (value: any): boolean => {
  return value === undefined || value === null || value === "";
};
