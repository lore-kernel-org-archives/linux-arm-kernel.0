From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 20 Aug 2013 13:52:31 +0530
Subject: [PATCH v3 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
References: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
 <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
 <20130819052516.GT32147@intel.com>
 <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
Message-ID: <20130820082231.GE5810@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 03:58:41PM +0800, zhangfei gao wrote:
> > No, this is not the right approach.
> >
> > When patch is applied and you find an issue you fix the issue. I have already
> > pushed and merged this. So removing is a bad idea.
> > you provide a fix for this miss.
> >
> > Also for this you need to give due credit to Dan (reporter). That is how the
> > process works.
> >
> > Anyway I have applied the below fix and will push it out.
> >
> > ---
> > dmaengine: fix - error: potential NULL dereference 'chan'
> >
> > commit 7bb587f4 "dmaengine: add interface of dma_get_slave_channel" introduced
> > the above error so fix it
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Suggested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> Thanks Vinod for the kind education.
> Understand, will take care next time.
No issues...

> 
> BTW, it is strange I do not see such compile warning here :(
Try running smatch and you will see. Compiler will not worry about these, static
checkers would. Since the bug report is from Dan, my guess is it would be
triggered by Smatch.

~Vinod
