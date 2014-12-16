From: ykk@rock-chips.com (Kuankuan.Yang)
Date: Tue, 16 Dec 2014 17:48:54 +0800
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <20141216093443.GN11285@n2100.arm.linux.org.uk>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
 <20141215104029.GE11285@n2100.arm.linux.org.uk>
 <20141215120205.GZ11764@sirena.org.uk> <548EDDC2.9050104@rock-chips.com>
 <20141215161827.GE11764@sirena.org.uk> <548FCE8F.7090106@rock-chips.com>
 <20141216093443.GN11285@n2100.arm.linux.org.uk>
Message-ID: <54900006.9060701@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014?12?16? 17:34, Russell King - ARM Linux ??:
> On Tue, Dec 16, 2014 at 02:17:51PM +0800, Kuankuan.Yang wrote:
>> hdmi-audio driver share irq with dw_hdmi driver,  for continuing AHBAUDDMA
>> or for detecting hdmi insert.
>> So maybe it's hard to switch to simple-card way,  Russell what's your
>> opinion ?
> My "opinion" is that I need to spend some time looking in depth at both
> your code and my code before I can form an idea of how to proceed.
>
> However, since I seem to be spending a lot of time chasing regressions
> which have appeared in v3.18, I don't have a lot of time to look at this
> right now.
>
okay, if u got any ideas, wish u can let me know, thks.
