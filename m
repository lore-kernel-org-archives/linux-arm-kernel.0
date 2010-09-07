From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:14:48 +0100
Subject: [PATCH 0/2] s3c24xx: fix s3cmci DMA support
In-Reply-To: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
References: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4C86C768.2000100@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 16:09, Vasily Khoruzhick wrote:
> This series fixes DMA support for s3c24xx SoCs, now it's
> possible to use DMA with s3cmci driver. It was tested on
> rx1950 (s3c2442), h1940 (s3c2410) and freerunner (s3c2442),
> unfortunately s3cmci doesn't work with SDIO cards when DMA
> is enabled, but at least patch breaks nothing - sound works
> OK on freerunner, and it's still possible to use PIO.

hmm, i've not got 1/2 of this?
