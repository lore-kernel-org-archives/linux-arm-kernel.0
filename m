From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 28 Aug 2012 12:50:10 +0300
Subject: [PATCH v2 02/14] MFD: twl4030-audio: Convert to use devm_kzalloc
In-Reply-To: <1344954162-7985-3-git-send-email-peter.ujfalusi@ti.com>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
 <1344954162-7985-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346147410.2182.96.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-08-14 at 17:22 +0300, Peter Ujfalusi wrote:
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I think this one could use a short commit message, also about why
kfree():s are dropped (handled internally by devm_* etc.)

-Tero
