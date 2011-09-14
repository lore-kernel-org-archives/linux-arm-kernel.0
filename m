From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Sep 2011 14:19:02 +0100
Subject: [PATCH 0/6] zImage improvements with DTB append and ATAG
	compatibility
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <20110914131902.GD2104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 01:41:40AM -0400, Nicolas Pitre wrote:
> This is the latest incarnation of my patch series allowing a DTB
> to be appended to zImage, including the ATAG conversion wrapper and
> other minor cleanups.
> 
> This can also be pulled from:
> 
> 	git://git.linaro.org/people/nico/linux zImage_DTB_append
> 
> This works for me on the test setup I have.
> ACKs/Tested-By's would be appreciated.  

For the series:

Tested-by: Dave Martin <dave.martin@linaro.org>

Tested in Thumb-2 with my almost-ready vexpress DT patches,
including the ATAG merging support.

Cheers
---Dave
