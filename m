From: davidb@codeaurora.org (David Brown)
Date: Wed, 08 Jun 2011 15:23:10 -0700
Subject: [PATCH 0/4] drivers/iommu/ relocations
In-Reply-To: <20110608093546.GG4407@amd.com> (Joerg Roedel's message of "Wed,
	8 Jun 2011 11:35:46 +0200")
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<20110608093546.GG4407@amd.com>
Message-ID: <8yar574klo1.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08 2011, Roedel, Joerg wrote:

> Great, thanks. I'll apply the patches as soon as the relevant ACKs come
> in. Looking at the MAINTAINERS file David Brown needs to ACK the MSM
> patch and David Woodhouse the VT-d patch.
>
> David B., David W., is this direction ok for both of you?

I think it is a good direction to move in.  I'll reply to the patch
directly to comment on it.

> My suggestion is that the ARM tree pulls in the necessary changes from
> the IOMMU tree and the IOMMU code goes upstream through Ingo or directly
> to Linus (with some time in linux-next, of course). Thoughts?

This seems the cleanest to me.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
