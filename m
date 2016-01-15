From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 15 Jan 2016 12:05:19 -0500
Subject: [PATCH V12 2/7] dma: hidma: Add Device Tree support
In-Reply-To: <20160115153054.GL3262@leverpostej>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-3-git-send-email-okaya@codeaurora.org>
 <20160115151637.GJ3262@leverpostej> <20160115153054.GL3262@leverpostej>
Message-ID: <569926CF.6030205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2016 10:30 AM, Mark Rutland wrote:
> Further to my reply below, I'm generally uncomfortable with some
> properties (max-* need a better description if they are a HW
> requirement, and probably should not be present otherwise). 

I'll add more description. 

> I'm also
> concerned that information necessary for the advertised use-case of the
> device (e.g. IOMMUs) is missing [1], and we're missing parts of the
> story necessary to review this for correctness.

OK. Let me work on this. I tried to capture as much documentation as possible
into the series before. One reviewer said I should add it. Another reviewer said I should 
remove it. 

Where would be the best place to document the use case? 
- In the source file?
- In the commit message?
- In the device-tree documentation?

I'll try to write up something based on your and Mark Zyngier's questions for the 
next release.

> 
> Until that's settled, I don't think this is ready yet, and I don't think
> this should be picked up.
> 
> I'm sorry to say that at this stage, as I realise that may sound
> obstructive. That's not my intention, and I hope we can figure out those
> details quickly.

I hope so too. I'm going towards V20 with small nitpicks rather than the good 
feedback like yours.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
