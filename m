From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 15 Mar 2012 19:45:09 -0400 (EDT)
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <20120315195753.GA2842@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de> <4F621939.9040906@ti.com>
 <20120315195753.GA2842@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1203151934560.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Mar 2012, Russell King - ARM Linux wrote:

> I really don't like these behind-the-scenes discussions which never then
> get followed up in public, and people then start quoting what was "agreed"
> as that's the way things must be done.
> 
> It's a bit like folk at the recent Linaro Connect apparantly discussing
> my machine registry and deciding that it should be shut down.  No one
> has yet talked to me about that or even done the curtesy of asking me
> what my view is.

Let me catch the ball in flight here as the responsible folk was me.

For the transition to DT to be effective for new boards on ARM, I 
suggested that the machine registry would need to be closed at this 
point i.e. no new additions to it.  As far as I remember, Vincent 
volunteered to talk to you about it, which he apparently did within the 
same hour.  That's all there was to it.


Nicolas
