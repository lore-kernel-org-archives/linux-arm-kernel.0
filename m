From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Apr 2018 11:08:02 +0800
Subject: [PATCH] ARM: dts: imx6ull: add UART5 input select register
 definition
In-Reply-To: <0977332f-fb45-6d6d-8643-6efdce5d14a2@i2se.com>
References: <1522189496-27837-1-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5CB=JkNqtkSf+QE_rjwNsOutfsS4=nWW0uVZdV63Op+eA@mail.gmail.com>
 <4f010fbd-9f6a-1f4e-efb5-564fba1b6cf6@i2se.com>
 <0977332f-fb45-6d6d-8643-6efdce5d14a2@i2se.com>
Message-ID: <20180418030801.GP25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 10:17:14AM +0200, Stefan Wahren wrote:
> >I'm okay with the second version of the patch, but i noticed that
> >at least UART5_RTS_B_SELECT_INPUT is also affected.
> >
> >The bits for the iMX6UL:
> >
> >000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
> >001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
> >010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
> >011 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
> >100 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
> >101 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8
> >
> >But for the iMX6ULL:
> >
> >000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
> >001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
> >010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
> >011 UART1_CTS_B_ALT9 ? Selecting Pad: UART1_CTS_B for Mode: ALT9
> >100 UART1_RTS_B_ALT9 ? Selecting Pad: UART1_RTS_B for Mode: ALT9
> >101 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
> >110 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
> >111 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8
> >
> >Comparing the datasheets isn't fun ...
> >
> >Should i provide a patch for this or is there a easier way to
> >figure out all the differences?
> 
> gentle ping ...

You're welcomed to send a patch for that.

Shawn
