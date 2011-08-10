From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Aug 2011 10:16:35 +0100
Subject: Enabling runtime P2V by default (Re: [PATCH 3/5] mach-u300:
	patch physoffset by default)
In-Reply-To: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110810091635.GF1831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 09:41:38PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This works like a charm so I'll just default-select it.

Well, we can remove the EXPERIMENTAL status of this option now.  This
raises the question is whether we should now default it to 'y' - I
think we should.  Anyone have any objections?
