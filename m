From: tony@atomide.com (Tony Lindgren)
Date: Sun, 10 Jun 2018 23:29:04 -0700
Subject: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
In-Reply-To: <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
Message-ID: <20180611062904.GO5738@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
> Great. I thought I completely misunderstood you. But I don't see what
> adding another function will accomplish. A QUIRK flag used in the same
> function would work well enough.

Fine with me as long as the function stays simple for both
syss and sysc reset.

Regards,

Tony
