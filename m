From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 May 2013 13:02:02 +0100
Subject: [GIT PULL] Urgent omap timer fix for current merge window
In-Reply-To: <20130506234610.GK28721@atomide.com>
References: <20130506234610.GK28721@atomide.com>
Message-ID: <20130507120202.GK21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 04:46:11PM -0700, Tony Lindgren wrote:
> Vaibhav Hiremath (1):
>       ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a

Neither your pull request subject nor the above summary line really
sum up what the problem is - the real problem is "fix breakage causing
OMAP to fail to boot".

I've just been chasing this problem and the descriptions given on this
just suggest that it's a timer issue not a non-boot issue.
