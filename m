From: dwalker@fifo99.com (Daniel Walker)
Date: Tue, 29 Mar 2011 12:22:40 -0700
Subject: [PATCH] msm: watchdog: support watchdog on 8x60 and 8960
In-Reply-To: <1301105894-22835-1-git-send-email-johlstei@codeaurora.org>
References: <1301105894-22835-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1301426560.4049.0.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-25 at 19:18 -0700, Jeff Ohlstein wrote:
> The msm watchdog driver is present in kernel only. It does not use the
> built-in Linux watchdog api. This is because the primary function of
> our watchdog is detecting bus lockups and interrupts being turned off
> for long periods of time. We wanted this functionality to be present
> regardless of the userspace the kernel is running beneath. Userspace
> is
> free to have its own watchdog implemented in software. 

Are you saying this is mostly a debugging facility ? The interrupts off
thing I can see as just debugging, but I don't understand the bus
lockups part.

Daniel
