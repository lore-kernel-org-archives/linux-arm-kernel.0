From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 May 2017 14:46:24 +0200
Subject: [PATCH v3] ARM: dts: mvebu: add support for Linksys WRT3200ACM
 (Rango)
In-Reply-To: <20170524124111.GA24341@lunn.ch> (Andrew Lunn's message of "Wed,
 24 May 2017 14:41:11 +0200")
References: <20170524061647.4238-1-ralph.sennhauser@gmail.com>
 <20170524124111.GA24341@lunn.ch>
Message-ID: <87h90awhgf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., mai 24 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, May 24, 2017 at 08:16:46AM +0200, Ralph Sennhauser wrote:
>> The Linksys WRT3200ACM (Rango) is the lates Armada-385 based router in
>> the Linksys WRT AC Series which got released in October 2016.
>> 
>> Key differences to the earlier Armada-385 based devices in the series is
>> a bigger flash chip, next generation wireless modules (Marvell 88W8964)
>> in the mini pcie slots as well as a Marvell SD8887. Finally the CPU is
>> clocked at 1866 GHz by default.
>> 
>> The file armada-385-linksys-rango.dts is loosly based off of a DTS
>> authored by Imre Kaloz.
>> 
>> As Rango is part of the armada-385-linksys family of boards use the
>> armada-385-linksys.dtsi as basis. As for functional differences to Imre
>> Kaloz dts, the wlan LEDs aren't connected to the expander chip pca9635
>> but directly to GPIOs. Then mpp47 controls the USB2.0 port and not the
>> USB3.0 port, so use the correct GPIO mpp44 for it. Finally use
>> non-removable instead of broken-cd with the sdhci node to avoid polling.
>> 
>> Other changes can be categorized as just cleanup / reorganization due to
>> using the armada-385-linksys.dtsi.
>> 
>> URL:
>> https://github.com/openwrt/openwrt/blob/0abc3fa5a996daf7dafdc7794ccfe3fa7e955c5a/target/linux/mvebu/files/arch/arm/boot/dts/armada-385-linksys-rango.dts
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/dt

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
