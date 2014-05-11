From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 11 May 2014 09:34:47 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <20140510135737.GA1878@shlinux1.ap.freescale.net>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
 <20140510131815.GT2794@dragon>
 <20140510135737.GA1878@shlinux1.ap.freescale.net>
Message-ID: <20140511013446.GU2794@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 10, 2014 at 09:57:39PM +0800, Li Jun wrote:
> As Peter suggested, do not enable OTG_FSM in defconfig since there are very few
> HNP&SRP capable device in market. With OTG_FSM enabled, even USB_OTG_WHITELIST
> is not selected, the OTG port still can't work the same as before if you connect
> a normal usb device to it.

Oh, okay.  In that case, I will have to drop OTG_FSM from defconfig.
Thanks for the info.

Shawn
