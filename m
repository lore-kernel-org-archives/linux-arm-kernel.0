From: khilman@ti.com (Kevin Hilman)
Date: Wed, 18 Apr 2012 11:29:49 -0700
Subject: [PATCH v2 0/9] PM: Create the AVS class of drivers
In-Reply-To: <1332173578-27422-1-git-send-email-j-pihet@ti.com> (jean pihet's
 message of "Mon, 19 Mar 2012 17:12:49 +0100")
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Message-ID: <87aa28ki5e.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> AVS is a power management technique which controls the operating

nit: you don't define AVS anywhere here, so those not familiar with the
technique will probably be lost in acronyms.  I suggest you add what it
means after the first use: e.g.  "AVS (Adaptive Voltage Scaling) is
a...."

Kevin
