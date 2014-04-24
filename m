From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 14:08:23 +0100
Subject: [PATCH v2 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <CACRpkdbT94HqVroM_0gSJJ8Q2+YaKXLwjFGMn+4SCa_PYiF19Q@mail.gmail.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
 <CACRpkdbT94HqVroM_0gSJJ8Q2+YaKXLwjFGMn+4SCa_PYiF19Q@mail.gmail.com>
Message-ID: <20140424130823.GT26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 02:52:20PM +0200, Linus Walleij wrote:
> - Why do hardware engineers seek to reinvent wheels like pin
>   controllers, GPIO and DMA engines all the time :-/

They think they have a rectangular pin cross-section which needs special
treatment to fit into the round hole in a turned-pin socket. :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
