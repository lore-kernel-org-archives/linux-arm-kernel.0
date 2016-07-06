From: joe@perches.com (Joe Perches)
Date: Wed, 06 Jul 2016 09:40:49 -0700
Subject: [PATCH v6 00/18] Add support for FDMA DMA controller and slim
 core rproc found on STi chipsets
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467823249.8360.28.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 09:54 +0100, Peter Griffin wrote:
> This patchset adds support for the Flexible Direct Memory Access (FDMA) core
> found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
> with a dedicated firmware. It is a general purpose DMA controller supporting
> 16 independent channels and data can be moved from memory to memory or between
> memory and paced latency critical real time targets.
[]
> ?include/linux/remoteproc/st_slim_rproc.h??????????|??53 ++

Is this directory really necessary?

Why shouldn't this file be local to drivers/remoteproc/?
