From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 11 Jul 2014 16:43:56 +0530
Subject: [STLinux Kernel] [PATCH v3 0/5] phy: miphy365x: Introduce support
 for MiPHY365x
In-Reply-To: <20140711110547.GA23439@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <53BD572C.4060406@ti.com>
 <20140710153548.GB26886@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140711103104.GC30519@lee--X1>
 <20140711110547.GA23439@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <53BFC6F4.2060804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 11 July 2014 04:35 PM, Peter Griffin wrote:
> Hi Lee,
> 
> On Fri, 11 Jul 2014, Lee Jones wrote:
>>> One small point, patch 5 which adds the DT nodes may not apply as the file got
>>> renamed from stih416-b2020-revE.dts to stih416-b2020e.dts.
>>
>> Not required, Git should handle this seamlessly.
> 
> I didn't ask you to do anything.
> 
> Also when I made the same mistake, GIT
> did not handle it seamlessly and I got the following query
> from Ulf http://www.mail-archive.com/devicetree at vger.kernel.org/msg33926.html
> 
> So in case Kishon has the same problem I thought I'd do a pre-emptive strike!

thanks.. but I wouldn't be merging the dt node stuff. I think the second patch
is shared by both dt patch and driver. In that case one of me or whoever merges
the dt patch will create a branch and both of us will merge it.

Lee,
Your cover letter did not have the patch subjects. When you send the next
version can you use --cover-letter option to create the cover letter?

Thanks
Kishon
