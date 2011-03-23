From: davidb@codeaurora.org (David Brown)
Date: Wed, 23 Mar 2011 15:42:47 -0700
Subject: [trivial PATCH 1/2] treewide: Fix iomap resource size
	miscalculations
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
	(Joe Perches's message of "Wed, 23 Mar 2011 12:55:36 -0700")
References: <cover.1300909445.git.joe@perches.com>
	<c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
Message-ID: <8ya39md7920.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23 2011, Joe Perches wrote:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/video/msm/mddi.c          |    2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
