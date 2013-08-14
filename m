From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Aug 2013 13:58:12 +0530
Subject: [PATCH v2 00/11] dma: pdma: some patches needed for PXA DT
 environments
In-Reply-To: <52067602.5040901@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
 <52067602.5040901@gmail.com>
Message-ID: <20130814082812.GL32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 07:18:58PM +0200, Daniel Mack wrote:
> On 10.08.2013 18:52, Daniel Mack wrote:
> > This is v2 of my series to add more features to the pdma driver.
> 
> I forgot to mention that this series depends on a patch from Zhangfei
> Gao which provides dma_get_slave_channel(). It was posted here:
> 
>   http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
Okay i saw this later, since I had kept that in branch had to merge it first
and then redo yours.

I have applied all till Pause, resume patch for which i have commented. The
patch after that failed to apply, perhpas due to dependency on this one. So you
can rebase those two and resend

~Vinod
