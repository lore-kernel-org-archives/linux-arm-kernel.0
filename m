From: davidb@codeaurora.org (David Brown)
Date: Tue, 15 Nov 2011 21:00:46 -0800
Subject: [PATCH 4/4] mmc: Add mmc_host_<level> logging
In-Reply-To: <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
References: <cover.1321398814.git.joe@perches.com>
 <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
Message-ID: <20111116050046.GA422@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 03:32:08PM -0800, Joe Perches wrote:

> Centralize the pr_<level> uses of mmc_hostname into specific
> mmc_host_<level> calls to allow a flexible presentation style
> and shorten the code a bit.

>  drivers/mmc/host/msm_sdcc.c     |  101 ++++++++++++++++++---------------------

The MSM ones at least are quite straightforward, so I'm fine with this
part of the change.

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
