From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Jan 2016 17:51:02 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124203516.GH8644@n2100.arm.linux.org.uk>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
 <20151124103948.GZ8644@n2100.arm.linux.org.uk>
 <20151124200730.GA25963@codeaurora.org>
 <20151124203516.GH8644@n2100.arm.linux.org.uk>
Message-ID: <20160113015102.GF22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Russell King - ARM Linux wrote:
> On Tue, Nov 24, 2015 at 12:07:30PM -0800, Stephen Boyd wrote:
> 
> > My understanding is that we want to support CPU_V7VE without
> > CPU_V7 enabled so that it uses the idiv instructions in that
> > configuration. When V7VE and V7 are both enabled, we should
> > degrade to the aeabi functions, and the same is true for when
> > V7VE is disabled.
> 
> Let me have another look at this, it's been a while since I touched these
> options...
> 

Any ideas on how to move forward on this? I don't have a problem
removing the duplication, but I'm not sure what else can be done.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
