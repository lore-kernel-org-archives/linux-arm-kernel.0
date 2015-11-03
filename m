From: tj@kernel.org (Tejun Heo)
Date: Tue, 3 Nov 2015 17:07:01 -0500
Subject: [PATCH v6 1/3] percpu: remove PERCPU_ENOUGH_ROOM which is stale
 definition
In-Reply-To: <36E66A14-F5AE-45DA-A759-82F1BA5DFE98@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-2-git-send-email-jungseoklee85@gmail.com>
 <20151102191044.GA9553@mtj.duckdns.org>
 <36E66A14-F5AE-45DA-A759-82F1BA5DFE98@gmail.com>
Message-ID: <20151103220701.GC5749@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 03, 2015 at 11:12:51PM +0900, Jungseok Lee wrote:
> On Nov 3, 2015, at 4:10 AM, Tejun Heo wrote:
> 
> Dear Tejun,
> 
> > On Sun, Nov 01, 2015 at 07:46:15AM +0000, Jungseok Lee wrote:
> >> As pure cleanup, this patch removes PERCPU_ENOUGH_ROOM which is not
> >> used any more. That is, no code refers to the definition.
> >> 
> >> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> > 
> > Applied to percpu/for-4.4.
> 
> Thanks for taking care of this!

Can you please refresh the patch so that it also drops
PERCPU_ENOUGH_ROOM definition from ia64?

Thanks.

-- 
tejun
