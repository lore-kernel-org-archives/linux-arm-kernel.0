From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Oct 2012 20:19:37 +0200
Subject: [PATCH] ARM: dts: exynos4: Enable serial controllers on Origen
 and SMDKV310
In-Reply-To: <01d201cdb116$59de2520$0d9a6f60$%kim@samsung.com>
References: <1349701968-6675-1-git-send-email-t.figa@samsung.com>
 <16890730.oeOgcP5xf2@flatron>
 <01d201cdb116$59de2520$0d9a6f60$%kim@samsung.com>
Message-ID: <1375453.WR9khS7opQ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 of October 2012 21:03:01 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > However I think this should be considered a fix, because without it
> > serial console on Origen and SMDKV310 will be broken.
> 
> Well, I couldn't find any broken due to miss this for v3.7. I think,
> there is no usage of serial controller in mainline for Origen and
> SMDKV310 now. So this should be queued for -next. If not, please let me
> know.

Personally I'm fine with this, but it sounds a bit off, since (correct me 
if I am wrong) it looks like serial console is the only way to check if 
the board boots.

Best regards,
Tomasz Figa
