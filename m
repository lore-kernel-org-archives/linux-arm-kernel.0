From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2011 22:18:29 +0000
Subject: [PATCH] ARM: pl2x0/pl310: Refactor Kconfig to be more maintainable
In-Reply-To: <4ED531C3.8050004@gmail.com>
References: <1322584345-19193-1-git-send-email-dave.martin@linaro.org>
 <4ED531C3.8050004@gmail.com>
Message-ID: <20111129221829.GR9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 01:25:55PM -0600, Rob Herring wrote:
> But as you can see, that's rarely the case...

That's because I don't always catch them anymore.

It's something that does need sorting out though, because it makes
conflict resolution harder to just have people appending to the end.
With a sorting order in place, it helps spread the additions and so
reduce the conflicts.
