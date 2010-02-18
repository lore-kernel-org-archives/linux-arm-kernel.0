From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 18 Feb 2010 09:32:39 +0000
Subject: [PATCH 2/2] ARM: SMDK6410: Register IISv4 device
In-Reply-To: <1b68c6791002171707r71bfee5ev5bea8daa7537a975@mail.gmail.com>
References: <1266433400-26780-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1266433400-26780-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1b68c6791002171707r71bfee5ev5bea8daa7537a975@mail.gmail.com>
Message-ID: <20100218093239.GA3315@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 10:07:53AM +0900, jassi brar wrote:
> On Thu, Feb 18, 2010 at 4:03 AM, Mark Brown

> > + ? ? ? &s3c64xx_device_iisv4,

> Since, we now compile dev-audio.c unconditionally, I think this should be ok.

> Acked-by: Jassi Brar <jassi.brar@samsung.com>

This is actually a revised version of the patch, rather than the
original (I've been carrying it for over a release now...).
