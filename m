From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 19 Sep 2011 13:32:14 -0500
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <20110919182544.GY16381@n2100.arm.linux.org.uk>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<CAH+eYFBSiL44CMOpgED+TAOTUH_dQMaKKu=hC3ynG0Y2nQ8ekw@mail.gmail.com>
	<CAB-zwWi1K8y8fHzy0hgcFPgSfhMrZNfoKQ9xuU00Y1sLg6ZBmw@mail.gmail.com>
	<20110919144313.GU16381@n2100.arm.linux.org.uk>
	<20110919165943.GX16381@n2100.arm.linux.org.uk>
	<CAPnjgZ1JDGt7Dzp9VrRKKApeZ9RT9oqry+UkQZwVCw1P+t9pew@mail.gmail.com>
	<20110919182544.GY16381@n2100.arm.linux.org.uk>
Message-ID: <CAB-zwWhxCJSqKkt-zTYFE2j5vXKGegYrYp2z4PnDyvurvSt0Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 19, 2011 at 1:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> I think I'm going to have to drop the generic bug support for the time being.

In this case then my patch can targeted for 3.1 and -stable, right? I
abandoned my change because the generic bug patch was the better
solution in the long term, but if it is being delayed I can submit
mine with your blessing.

https://lkml.org/lkml/2011/3/31/490

It just forces the compiler to generate the right code through
volatile, and while at it I could fix the other similar situations
(also noted in the patch).

Omar
