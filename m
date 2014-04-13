From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 18:55:20 +0200
Subject: Marvell Orion5x boards with PCIe, and DT conversion
In-Reply-To: <53480402.5030101@free.fr>
References: <20140411155735.109c5d04@skate>
	<53480402.5030101@free.fr>
Message-ID: <20140413185520.5f9e7165@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Albert ARIBAUD,

On Fri, 11 Apr 2014 17:02:26 +0200, Albert ARIBAUD wrote:

> I'll gladly test these patches on my faithful Orion ED Mini V2. Not sure 
> if it uses PCIe, but I suspect it does not.

Thanks for the proposal. Unfortunately, it turns out that the Orion ED
Mini V2 is one of the two boards I already have, so I can test on this
one. However, it would definitely be useful to have your testing and
feedback.

I've posted the patch series on LAKML just a few hours ago, you can
also grab the code from:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/3.15/orion

In this branch, Orion ED Mini v2 is fully converted to the Device Tree.

> How does this play out with U-Boot? I mean, I know that you can produce 
> a kernel which embeds the device tree and will load without U-Boot 
> knowing anything about them, but OTOH, U-Boot has some support for DTs, 
> and could possibly use the DT files too.

For now, I'm using the U-Boot included with the boards, so it does not
have FDT support, which means I'm using appended DTBs.

Do you know if UART booting works for Orion boards? If not, what is the
recovery mechanism if you screw up while reflashing U-Boot?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
