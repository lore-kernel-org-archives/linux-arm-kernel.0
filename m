From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 18:15:01 +0000
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
In-Reply-To: <4F3952C7.3040502@codeaurora.org>
References: <alpine.LFD.2.02.1202022016480.2759@xanadu.home>
 <1328234629-32735-1-git-send-email-sboyd@codeaurora.org>
 <CAH+eYFCKcPzMMp_Ef5iX0Xp=xK8MdvJoUBRgKGT56SVjY5DXoA@mail.gmail.com>
 <alpine.LFD.2.02.1202131307430.24536@xanadu.home>
 <4F3952C7.3040502@codeaurora.org>
Message-ID: <20120213181501.GD25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 10:13:27AM -0800, Stephen Boyd wrote:
> Thanks. Russell has already merged the original patch to the fixes
> branch. Hopefully he can fold this one in.

Nope, I've asked Linus to pull it.

So do we conclude that the original patch wasn't properly tested? :P
