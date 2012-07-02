From: tony@atomide.com (Tony Lindgren)
Date: Sun, 1 Jul 2012 23:26:49 -0700
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <4FECA9DD.8050505@ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <4FECA9DD.8050505@ti.com>
Message-ID: <20120702062649.GN4202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120628 12:05]:
> 
> Tony, have you tried using any of the mtd kernel tests to verify OneNAND
> read/write is working on your n900? For example ...
> 
> # insmod mtd_pagetest.ko dev=<mtd-part-num>
> 
> _NOTE_ that above test erases the OneNAND! ;-)

Ehh not thanks.

Tony
