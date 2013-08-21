From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Aug 2013 00:52:47 -0700
Subject: [PATCH] ARM: OMAP2+: Remove legacy device creation for McPDM
 and DMIC
In-Reply-To: <1373551488-3816-1-git-send-email-peter.ujfalusi@ti.com>
References: <1373551488-3816-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20130821075247.GX7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130711 07:11]:
> McPDM and DMIC only available on OMAP4/5 which no longer boots in legacy
> mode.
> The code to create the devices in legacy mode can be removed.

Thanks applying to omap-for-3.12/fixes-non-critical.

Regards,

Tony
