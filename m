From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 12:04:11 +0000
Subject: [patch 1/4] [ARM] mmp: support PJ4 core
In-Reply-To: <771cded00912062218w1296d9eem32ead5466b675838@mail.gmail.com>
References: <771cded00912062218w1296d9eem32ead5466b675838@mail.gmail.com>
Message-ID: <20091207120411.GB19348@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 01:18:50AM -0500, Haojian Zhuang wrote:
> >From e4abbf0b65f7581867bbca492741fe5617bc346d Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 4 Dec 2009 08:35:17 -0500
> Subject: [PATCH] [ARM] mmp: support PJ4 core
> 
> Marvell PJ4 core is compatible to ARMv6 architecture.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Saeed Bishara already submitted this as part of the Marvell Dove
patchset - though it looks like it should've been submitted separately
as you have done (since the core is a shared entity.)

Shouldn't Lennert's sign-off also be on this patch (did it originate
from the Dove folk?)
