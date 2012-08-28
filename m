From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Aug 2012 09:48:26 -0700
Subject: [PATCH v2 02/14] MFD: twl4030-audio: Convert to use devm_kzalloc
In-Reply-To: <1346147410.2182.96.camel@sokoban>
References: <1344954162-7985-1-git-send-email-peter.ujfalusi@ti.com>
 <1344954162-7985-3-git-send-email-peter.ujfalusi@ti.com>
 <1346147410.2182.96.camel@sokoban>
Message-ID: <20120828164825.GA4534@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 12:50:10PM +0300, Tero Kristo wrote:
> On Tue, 2012-08-14 at 17:22 +0300, Peter Ujfalusi wrote:
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> I think this one could use a short commit message, also about why
> kfree():s are dropped (handled internally by devm_* etc.)

Honestly I think people should be able to figure this out, it's not like
it's an obscure API nobody ever used before.
