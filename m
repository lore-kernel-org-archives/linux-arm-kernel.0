From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Jan 2011 10:26:29 -0200
Subject: [PATCH 1/3] ARM: mach-mx5: Fix build for mx53_loco and mx53_smd
In-Reply-To: <20110127121928.GA1948@richard-laptop>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
	<20110127073009.GR9041@pengutronix.de>
	<20110127093044.GA30756@shlinux1.ap.freescale.net>
	<4D415BA2.2020207@freescale.com>
	<20110127121928.GA1948@richard-laptop>
Message-ID: <AANLkTimcsZtPz2JV=Kiq72vZUJVs7Ppmt9mV56zDDMtb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, Jan 27, 2011 at 10:19 AM, Richard Zhao <linuxzsc@gmail.com> wrote:
....

>> Right, these are removed later in my patch series.
> I didn't see your patch series in my freescale mailbox, until Sascha replied.
>>
>> After my patch series is applied we have a working UART1 console.
>>
>> Can we apply them?
> Sure. My two coins, why don't you squash patch 2 and 3. They're both small and
> modifying the same thing. It don't matter much. If you choose to send it again,
> you can merge my second patch.

I preferred to split the patch as I did originally:

1/3: Fix the build issue on MX53_LOCO and MX53_SMD
2/3: Make UART1 functional on MX53_LOCO
3/3: Remove UART2 and UART3.
(http://www.spinics.net/lists/arm-kernel/msg112234.html  )

You can then send a patch for adding the additional peripherals of
MX53_LOCO board after these patch series are merged.

Does it sound good for you?
....
> will you fix iomux issue here? I didn't see any other fix in your patch series.

UART1 IOMUX is fixed in patch 2/3.

Regards,

Fabio Estevam
