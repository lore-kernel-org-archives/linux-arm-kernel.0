From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jul 2015 04:10:17 -0700
Subject: [PATCH 1/4] ARM: dts: omap3-pandora: miscellaneous corrections
In-Reply-To: <1437441121-31658-1-git-send-email-notasas@gmail.com>
References: <1437441121-31658-1-git-send-email-notasas@gmail.com>
Message-ID: <20150721111017.GE17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [150720 18:14]:
> - add pandora specific compatible name
> - fix mmc2 card detect polarity
> - fix mmc1 and mmc2 write protect polarity
> - disable write protect pins because of production issue and add an
>   explanation why they are disabled
> - fix NAND partition name to reflect the correct address

Thanks applying all four into omap-for-v4.3/dt and also
now adding the dropping of the legacy board file into Linux
next.

Regards,

Tony
