From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:59:31 -0700
Subject: [GIT PULL] ARM: mvebu: dt for v4.13 (#1)
In-Reply-To: <87r2yj5cwk.fsf@free-electrons.com>
References: <87r2yj5cwk.fsf@free-electrons.com>
Message-ID: <20170619055931.GA13137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 17, 2017 at 08:47:07AM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt for mvebu for v4.13.
> 
> Gregory
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.13-1
> 
> for you to fetch changes up to 97800cf8b6a81cf17ad216ec9d0c8e78c68b7aef:
> 
>   ARM: dts: turris-omnia: Add generic compatible string for I2C EEPROM (2017-06-17 08:16:46 +0200)
> 
> ----------------------------------------------------------------
> mvebu dt for 4.13 (part 1)
> 
> - Add Linksys WRT3200ACM (Rango) support
> - Add PWM properties for gpio on Aramda XP and 38x
> - A couple of minor updates for the 98dx3236 and 98dx4251

Merged, but comment below:

> ----------------------------------------------------------------
> Andrew Lunn (2):
>       ARM: dts: mvebu: Add PWM properties to .dtsi files
>       ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan
> 
> Chris Packham (2):
>       ARM: dts: mvebu: add missing interrupt to 98dx4251 switch
>       ARM: dts: mvebu: disable the rtc on 98dx3236 SoC
> 
> Javier Martinez Canillas (1):
>       ARM: dts: turris-omnia: Add generic compatible string for I2C EEPROM
> 
> Ralph Sennhauser (13):
>       ARM: dts: mvebu: Add PWM properties for armada-38x
>       ARM: dts: armada-385-linksys: flatten dtsi
>       ARM: dts: armada-385-linksys: label nodes
>       ARM: dts: armada-385-linksys: flatten dependants
>       ARM: dts: armada-385-linksys: drop redundant properties in dependants
>       ARM: dts: armada-385-linksys: bm pools by label order
>       ARM: dts: armada-385-linksys: usb3 label cleanup
>       ARM: dts: armada-385-linksys: drop legacy DSA bindings
>       ARM: dts: armada-385-linksys: use binary unit prefixes
>       ARM: dts: armada-385-linksys: partition layout is board specific
>       ARM: dts: armada-385-linksys: group pins in pinctrl
>       ARM: dts: armada-385-linksys: fixup button node names
>       ARM: dts: mvebu: add support for Linksys WRT3200ACM (Rango)

So this is a patch to introduce the platform, and then in the same branch
a bunch of cleanups? Seems like it could have been squashed down.


-Olof
