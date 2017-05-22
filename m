From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:49:17 +0200
Subject: [PATCH 1/2] ARM: dts: orange-pi-zero: interrupt triggering for
 XR819 WiFi chip
In-Reply-To: <20170519213550.8434-2-geomatsi@gmail.com>
References: <20170519213550.8434-1-geomatsi@gmail.com>
 <20170519213550.8434-2-geomatsi@gmail.com>
Message-ID: <20170522074917.msy3sypver3kai5p@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

Thanks for your patches!

On Sat, May 20, 2017 at 12:35:49AM +0300, Sergey Matyukevich wrote:
> Specify interrupt triggering for XR819 SDIO WiFi chip
> on orange-pi-zero board.
> 
> For more details see: http://linux-sunxi.org/Wifi#Allwinner

Please don't reference details in a wiki page. URLs can change and
wiki page get rewritten. git history is immutable. Your commit log
should contain everything there is.

The patch itself looks good though.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/36f6dc73/attachment.sig>
