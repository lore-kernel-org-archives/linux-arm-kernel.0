From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jan 2014 07:06:12 +0100
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <CAL85gmCA4kBsRUMC_ENjGfCq5jM11iY5Jx_+A3V9XQDU0b7E0A@mail.gmail.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <201401132043.52491.arnd@arndb.de>
 <CAL85gmCA4kBsRUMC_ENjGfCq5jM11iY5Jx_+A3V9XQDU0b7E0A@mail.gmail.com>
Message-ID: <201401140706.13406.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 January 2014, Feng Kan wrote:
> 
> >
> > Is this related to the standard ARM SCU that manages multiprocessor
> > systems, or a different unit that uses the same name?
> 
> FKAN: You mean the snoop control unit in ARM. This is different from
> that, the main function of this unit is clk control.

Hmm, if it's *mainly* used for clocks, you may actually just want to
have a driver in drivers/clk for it that also performs a few of the
other things on the side.

	Arnd
