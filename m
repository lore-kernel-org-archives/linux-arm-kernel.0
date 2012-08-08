From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 8 Aug 2012 04:00:59 -0700
Subject: [PATCH 2/9] ARM: plat-s3c24xx: Don't use FIQ_START
In-Reply-To: <0af201cd7553$3346dd70$99d49850$%kim@samsung.com>
References: <20120805230238.GA1663@lizard>
 <1344207819-3415-2-git-send-email-anton.vorontsov@linaro.org>
 <0af201cd7553$3346dd70$99d49850$%kim@samsung.com>
Message-ID: <20120808110058.GA22197@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 07:47:26PM +0900, Kukjin Kim wrote:
> Anton Vorontsov wrote:
> > We're about to remove FIQ_START mess, so move the platform-specific
> > detail inside platform-specific s3c24xx_set_fiq().
> > 
> > Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks!

> BTW, how was going on the 'change FIQ_START to a variable' patch from Shawn
> Guo?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/106486.html

It's in Linus' tree already. My patch set is just a next step in
the same direction.

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
