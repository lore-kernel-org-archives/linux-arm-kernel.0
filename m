From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 18 Sep 2011 02:46:15 +0200
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <3353131.FJY7smc8i5@wuerfel>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
	<20110917112321.GE16381@n2100.arm.linux.org.uk>
	<20110917181907.GA16141@game.jcrosoft.org>
	<3353131.FJY7smc8i5@wuerfel>
Message-ID: <20110918004615.GC16141@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:56 Sat 17 Sep     , Arnd Bergmann wrote:
> On Saturday 17 September 2011 20:19:07 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > I agree about it I just mean that if you have the same board with 2 SoC which
> > are pin to pin compatible detect the soc type will be usefull as the soc
> > resource may not be the same
> 
> In that scenario, you would put all SOC specific data into one .dtsi
> file and all board data into another .dtsi file and then create a
> description for the combination using a trivial .dts file with two
> include statements. This is all solved outside of the kernel already,
> so there is no need for infrastructure in the kernel.
except in this case you must have 2 machine id which can be avoided if you can
detect the soc at kernel level

Best Regards,
J.
