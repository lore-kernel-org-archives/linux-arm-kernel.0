From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Apr 2010 12:16:09 +0100
Subject: [alsa-devel] [PATCH 1/4] pxa: add namespace on ssp
In-Reply-To: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
Message-ID: <20100409111609.GA13281@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 08:46:42AM -0400, Haojian Zhuang wrote:
> From b52a0d2687e82f81d38198cb450b6a39a9e53851 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 31 Mar 2010 15:08:55 -0400
> Subject: [PATCH] [ARM] pxa: add namespace on ssp
> 
> In order to prevent code ambiguous, add namespace on functions in ssp driver.

Liam acked these on IRC so I was going to apply them (the interface for
the sysclk configuration should be fixed, but that can be done as a
followup patch) but I can't seem to find a branch that these apply to -
they don't apply cleanly to either Eric's ssp_cleanup branch, the ASoC
for-2.6.35 branch, nor a merge of the two.
