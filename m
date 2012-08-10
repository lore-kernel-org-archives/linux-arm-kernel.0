From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Aug 2012 23:28:00 -0700
Subject: [PATCH 07/11] ARM: OMAP/ASoC: Zoom2: Let the codec to handle
 the hs_extmute GPIO
In-Reply-To: <1344418887-5262-8-git-send-email-peter.ujfalusi@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-8-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120810062800.GO11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 02:42]:
> Remove the use of set_hs_extmute callback and let the codec driver to
> handle the extmute GPIO.

Acked-by: Tony Lindgren <tony@atomide.com>
