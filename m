From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Dec 2014 09:34:43 +0000
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <548FCE8F.7090106@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
 <20141215104029.GE11285@n2100.arm.linux.org.uk>
 <20141215120205.GZ11764@sirena.org.uk>
 <548EDDC2.9050104@rock-chips.com>
 <20141215161827.GE11764@sirena.org.uk>
 <548FCE8F.7090106@rock-chips.com>
Message-ID: <20141216093443.GN11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 02:17:51PM +0800, Kuankuan.Yang wrote:
> hdmi-audio driver share irq with dw_hdmi driver,  for continuing AHBAUDDMA
> or for detecting hdmi insert.
> So maybe it's hard to switch to simple-card way,  Russell what's your
> opinion ?

My "opinion" is that I need to spend some time looking in depth at both
your code and my code before I can form an idea of how to proceed.

However, since I seem to be spending a lot of time chasing regressions
which have appeared in v3.18, I don't have a lot of time to look at this
right now.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
