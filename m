From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Aug 2016 09:51:12 +0200
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <CAK7LNAQYxQv0e0OSvRfH-wNYYaSCy9D_anqwNTDFa5Nhcv7PfQ@mail.gmail.com>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
 <20643424.8eBLZWavEG@wuerfel>
 <CAK7LNAT4rZoQJaPLiA_Hg=PJ9AD4Z-oLVadq5WDgQ2etCYUFFA@mail.gmail.com>
 <1779401.H3WQxbgf2J@wuerfel> <1472109754.3032.18.camel@pengutronix.de>
 <CAK7LNAQYxQv0e0OSvRfH-wNYYaSCy9D_anqwNTDFa5Nhcv7PfQ@mail.gmail.com>
Message-ID: <1472111472.3032.30.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.08.2016, 16:27 +0900 schrieb Masahiro Yamada:
> 2016-08-25 16:22 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > And the hi6220
> > driver, which doesn't have a user yet.
> 
> It does.
> 
> See arch/arm64/configs/defconfig

My mistake, I missed that hi6220_reset_init is a postcore_initcall, so
there is no compile time dependency on the reset driver.

regards
Philipp
