From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 16:46:26 +0100
Subject: [PATCH 09/10] ARM: mvebu: add Device Tree files for Armada 39x
 SoC and board
In-Reply-To: <20150220144547.GB13797@lunn.ch>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150206172153.GY25985@lunn.ch>
 <20150220151455.461b97bb@free-electrons.com>
 <20150220144547.GB13797@lunn.ch>
Message-ID: <20150220164626.5843fcda@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 20 Feb 2015 15:45:47 +0100, Andrew Lunn wrote:

> Lets look at this from the perspective of lies, damn lies, and
> statistics:
> 
> Kirkwood has a default pinmux configuration in kirkwood.dtsi. Two of
> the sixty six .dts files overwrite the defaults.
> 
> Dove has a default pinmux of uart1, but none for uart0.  None of the
> .dts files define a pinmux for uart0 and none overwrite the defaults
> for uart1.
> 
> Armanda XP has a default pinmux for uart2 and uart2 in armada-xp.dtsi,
> but none for uart0 or uart1. None of the .dts files define a pinmux
> for uart0 or uart1, and none overwrite the defaults for uart2 or
> uart3.
> 
> Armada 370 has default pinmux for uart0 and uart1. None of the .dts
> files overwrite the defaults.
> 
> I'm too lazy to look at 375, 380, and 385.
> 
> We have over 80 dts files here with defaults from a .dtsi file, and
> only two need anything other than defaults.

Fair enough :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
