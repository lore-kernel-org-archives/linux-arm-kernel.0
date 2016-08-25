From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Thu, 25 Aug 2016 09:40:28 +0800
Subject: [PATCH V5, 0/5] Add MediaTek USB3 DRD Driver
In-Reply-To: <1472038159.11480.2.camel@suse.com>
References: <1470730998-9563-1-git-send-email-chunfeng.yun@mediatek.com>
 <1472020923.27677.1.camel@mhfsdcap03> <1472038159.11480.2.camel@suse.com>
Message-ID: <1472089228.27677.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2016-08-24 at 13:29 +0200, Oliver Neukum wrote:
> On Wed, 2016-08-24 at 14:42 +0800, chunfeng yun wrote:
> > Dear all,
> > 
> >     Could you please help me to review the code? 
> 
> Is the structure
> 
> struct qmu_gpd
> 
> shared with the hardware? Do I read this correctly that
> you do PIO to endpoint 0 but DMA to the others?
> 
Yes, you are right.

> Could you resend the series?
> 
I will do it soon

Thank you.

> 	Regards
> 		Oliver
> 
> 
