From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 3 Sep 2013 23:39:05 +0300
Subject: [PATCH v3 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <521C0940.9000408@linaro.org>
References: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
 <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
 <20130819052516.GT32147@intel.com>
 <CAMj5Bkhq=kvfpYiMX0de3PBaAzOUfgPVELamaeMAWhHaoDgc8g@mail.gmail.com>
 <20130820081348.GV4713@mwanda> <521C0940.9000408@linaro.org>
Message-ID: <20130903203905.GA21040@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:04:48AM +0800, zhangfei wrote:
> On 13-08-20 04:13 PM, Dan Carpenter wrote:
> >On Tue, Aug 20, 2013 at 03:58:41PM +0800, zhangfei gao wrote:
> >
> >>BTW, it is strange I do not see such compile warning here :(
> >
> >This was a Smatch static checker warning, not a regular build
> >warning.
> >
> >regards,
> >dan carpenter
> >
> Dear Dan
> 
> Thanks for introducing this valuable tool.
> Have download from git://repo.or.cz/smatch.git
> 
> When trying use this tool, could get some warning,
> make CHECK="~/bin/smatch -p=kernel --no-data" C=1 | tee warns.txt
> 
> Also some strange warning, like "SQL error #2: no such table:
> caller_info", is it ignored?
> 

Oops.  I'll fix that.  The problem is that I don't normally test with
--no-data.  Sorry about that.

> Besides, when test this case for check smatch setting.
> Still not reproduce the issue, should be not config correct?

This warning requires that the cross function database be set up.

regards,
dan carpenter
