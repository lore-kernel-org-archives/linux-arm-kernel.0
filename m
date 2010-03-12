From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Mar 2010 10:04:54 +0000
Subject: [PATCH 1/2] Add support for Olimex SAM9-L9261 SBC
In-Reply-To: <20100312110032.2e57fdce@rechenknecht2k7>
References: <20100312105817.4392b594@rechenknecht2k7>
	<20100312110032.2e57fdce@rechenknecht2k7>
Message-ID: <20100312100454.GA29306@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 12, 2010 at 11:00:32AM +0100, Benjamin Valentin wrote:
> diff -urpN -x CVS linux-2.6.34-rc1/arch/arm/configs/sam9_l9261_defconfig linux-2.6.34-rc1-olimex/arch/arm/configs/sam9_l9261_defconfig
> --- linux-2.6.34-rc1/arch/arm/configs/sam9_l9261_defconfig	1970-01-01 02:00:00.000000000 +0200
> +++ linux-2.6.34-rc1-olimex/arch/arm/configs/sam9_l9261_defconfig	2008-10-28 06:08:46.000000000 +0200
> @@ -0,0 +1,1606 @@

Please think about your reviewers when you send patches - do you think
it's reasonable to expect reviewers to scroll through 1600 lines before
they get to something interesting to read?

Always split defconfig patches into a separate patch.
