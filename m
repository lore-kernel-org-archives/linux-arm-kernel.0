From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Feb 2012 14:23:29 -0800
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
In-Reply-To: <20120213181501.GD25655@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1202022016480.2759@xanadu.home>
 <1328234629-32735-1-git-send-email-sboyd@codeaurora.org>
 <CAH+eYFCKcPzMMp_Ef5iX0Xp=xK8MdvJoUBRgKGT56SVjY5DXoA@mail.gmail.com>
 <alpine.LFD.2.02.1202131307430.24536@xanadu.home>
 <4F3952C7.3040502@codeaurora.org>
 <20120213181501.GD25655@n2100.arm.linux.org.uk>
Message-ID: <4F398D61.9080501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/12 10:15, Russell King - ARM Linux wrote:
> On Mon, Feb 13, 2012 at 10:13:27AM -0800, Stephen Boyd wrote:
>> Thanks. Russell has already merged the original patch to the fixes
>> branch. Hopefully he can fold this one in.
> Nope, I've asked Linus to pull it.
>
> So do we conclude that the original patch wasn't properly tested? :P

Sigh. Lockdep strikes again! I promise I tested it with lockdep disabled.

It looks like Linus' hasn't pulled yet but maybe he just hasn't
published it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
