From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 15:00:12 +0100
Subject: ARM: topology: Checking for a failed kcalloc() in parse_dt_topology()?
Message-ID: <d28439db-9915-e0d9-9bfc-3436c943cbd4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Another run of a small script for the semantic patch language (Coccinelle)
pointed the implementation of the function ?parse_dt_topology? out for
further considerations.
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/kernel/topology.c?id=e05f574a0bb1f4502a4b2264fdb0ef6419cf3772#n285

Would it be useful to check the return value from a call of the
function ?kcalloc? also there?

Regards,
Markus
