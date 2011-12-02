From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Fri, 2 Dec 2011 14:17:17 +0100
Subject: [PATCH 1/3] ARM: msm: Remove MSM7x00 support
In-Reply-To: <20111201202632.GA25247@huya.qualcomm.com>
References: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
 <20111201201950.GE9581@n2100.arm.linux.org.uk>
 <20111201202632.GA25247@huya.qualcomm.com>
Message-ID: <201112021417.17082.GNUtoo@no-log.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>And I've learned what I needed to now: someone does still care about
>the target.
However in a response to the following mail:
[Question] RPC and SMD implementation
David Brown already told that:
>Is there much reason to get the msm72xx support into the kernel in the
>first place?  These targets are old, and I don't believe any new
>devices are being made using them
And:
>Things are a lot easier in the newer RPC/SMD versions,
>and I don't see a strong reason to keep the kruft in the kernel
>necessary to support the 72xx chips.
I guess that means that RPC for msm7x00 won't hit mainline.
So without RPC the port to mainline cannot be complete(no modem, no audio, no 
GPS,and maybe more depending on the device).

Denis.
