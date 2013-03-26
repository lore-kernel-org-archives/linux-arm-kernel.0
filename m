From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 26 Mar 2013 21:02:56 +0000
Subject: [PATCHv2 1/4] arm: orion5x: fix orion5x.dtsi gpio parameters
In-Reply-To: <20130325084312.GE5627@lunn.ch>
References: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
 <1364077797-21206-2-git-send-email-alex@digriz.org.uk>
 <20130325084312.GE5627@lunn.ch>
Message-ID: <20130326210256.GO7123@edkhil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 25, 2013 at 09:43:12AM +0100, Andrew Lunn wrote:
>If you look at Dove, Kirkwood, etc, you see:
>
>                gpio0: gpio at d0400 {
>                        compatible = "marvell,orion-gpio";
>                        #gpio-cells = <2>;
>                        gpio-controller;
>                        reg = <0xd0400 0x20>;
>                        ngpios = <32>;
>                        interrupt-controller;
>                        #interrupt-cells = <2>;
>                        interrupts = <12>, <13>, <14>, <60>;
>                };
>
>I think you also need to add
>
>                        interrupt-controller;
>                        #interrupt-cells = <2>;
>
Darn, I had noticed this and pondered, then thought to wait for someone brighter to point it out 
authoritively :)

Wanging out an update to this patch too.

Cheers

-- 
Alexander Clouter
.sigmonster says: I'd like some JUNK FOOD ... and then I want to be ALONE --
