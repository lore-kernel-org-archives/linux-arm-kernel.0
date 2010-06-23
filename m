From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Wed, 23 Jun 2010 17:22:35 +0200
Subject: [PATCH] otg/ulpi.c : fix register write
In-Reply-To: <4C222649.8050100@compulab.co.il>
References: <1277304632-11314-1-git-send-email-eric@eukrea.com>
	<4C222649.8050100@compulab.co.il>
Message-ID: <4C2226BB.1060402@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

Le 23/06/2010 17:20, Igor Grinberg a ?crit :
> and also:
>
> struct otg_io_access_ops {
>           int (*read)(struct otg_transceiver *otg, u32 reg);
>           int (*write)(struct otg_transceiver *otg, u32 val, u32 reg);
> };
>
> and please, look here:
> http://comments.gmane.org/gmane.linux.usb.general/32092
>
OK, you took the problem from the right side :-)

Thanks
Eric
