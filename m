From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 3 Nov 2017 08:12:28 -0700
Subject: [PATCH v3 18/22] clk: add support for clocks provided by SCMI
In-Reply-To: <c0b80daf-6361-87eb-fde6-a9d6a71e3e82@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-19-git-send-email-sudeep.holla@arm.com>
 <20171102072350.GO30645@codeaurora.org>
 <c0b80daf-6361-87eb-fde6-a9d6a71e3e82@arm.com>
Message-ID: <20171103151228.GS11011@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02, Sudeep Holla wrote:
> 
> 
> On 02/11/17 07:23, Stephen Boyd wrote:
> > Is there a lot of copy/paste going on from clk-scpi.c? Maybe it
> > could be consolidated?
> > 
> 
> Not much apart from the usual driver skeleton. Also SCPI specification
> will not be enhanced any further while SCMI will be. So they will
> deviated in the feature set going further. Even I was thinking of
> merging then together initially but based on some WIP changes to the
> specification, I thought it may not be good idea. But if we think it can
> be merged in future , I will do that for sure(for easy maintenance)
> 

Ok, no worries from me. Thanks for taking another look.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
