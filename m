From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 1 Sep 2011 17:27:28 +0530
Subject: [PATCH] arm: mach-davinci: use kzalloc()
In-Reply-To: <1312629976.5589.128.camel@localhost.localdomain>
References: <1312629976.5589.128.camel@localhost.localdomain>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257268CA8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 06, 2011 at 16:56:13, Thomas Meyer wrote:
> From: Thomas Meyer <thomas@m3y3r.de>
> 
>  Use kzalloc rather than kmalloc followed by memset with 0

Queuing this for v3.2. While applying, I changed the
subject to:

"ARM: davinci: edma: use kzalloc()"

to be more consistent with other patch headlines.

Thanks,
Sekhar
