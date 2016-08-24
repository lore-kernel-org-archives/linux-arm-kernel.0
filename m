From: oneukum@suse.com (Oliver Neukum)
Date: Wed, 24 Aug 2016 13:29:19 +0200
Subject: [PATCH V5, 0/5] Add MediaTek USB3 DRD Driver
In-Reply-To: <1472020923.27677.1.camel@mhfsdcap03>
References: <1470730998-9563-1-git-send-email-chunfeng.yun@mediatek.com>
 <1472020923.27677.1.camel@mhfsdcap03>
Message-ID: <1472038159.11480.2.camel@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-24 at 14:42 +0800, chunfeng yun wrote:
> Dear all,
> 
>     Could you please help me to review the code? 

Is the structure

struct qmu_gpd

shared with the hardware? Do I read this correctly that
you do PIO to endpoint 0 but DMA to the others?

Could you resend the series?

	Regards
		Oliver
