From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 06 Feb 2012 16:20:56 -0800
Subject: Common clock API for i.MX
In-Reply-To: <20120125084533.GD1068@n2100.arm.linux.org.uk>
References: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
 <20120125084533.GD1068@n2100.arm.linux.org.uk>
Message-ID: <4F306E68.1090507@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 12:45 AM, Russell King - ARM Linux wrote:
>
> My conclusion, therefore, is that there's very little actual interest
> amongst the ARM community to move towards a common clk API.

MSM is most certainly interested.

> I'm rather disappointed by that, and have been wondering for some time
> why I wasted my time over the clk_prepare() stuff, and wondering why the
> hell I bothered putting it in mainline.  I must have been under the
> mistaken impression that this is something people wanted.  Obviously not.

The time you spent on this certainly wasn't a waste. Once it got into 
the mainline, we already back ported the stubs into our kernel tree. I 
have already laid out a plan to migrate of all MSM drivers to the new 
APIs and it's work in progress. Some drivers devs are already working on it.

Unfortunately, the fact that not all the MSM drivers are already merged 
onto the mailine is a separate issue that I don't have much control 
over. So, the interest for these APIs aren't easily visible to you.

> There's a good saying here: actions speak louder than words.  The action
> here is the lack of patches from platform maintainers.  That definitely
> shouts.

You are welcome to look at our kernel tree for proof of interest. I know 
internal trees aren't of much relevance to you, but you can take that as 
a precursor of what to expect when changes get pushed upstream.

> As a result of the lack of motivation by others over this, I've lost
> interest in it.  Sorry.
Hopefully, this email is of some help in restoring your interest.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
