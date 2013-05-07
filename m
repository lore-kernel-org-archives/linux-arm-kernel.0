From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 May 2013 08:04:03 -0700
Subject: [GIT PULL] Urgent omap timer fix for current merge window
In-Reply-To: <20130507120202.GK21614@n2100.arm.linux.org.uk>
References: <20130506234610.GK28721@atomide.com>
 <20130507120202.GK21614@n2100.arm.linux.org.uk>
Message-ID: <20130507150402.GP28721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130507 05:07]:
> On Mon, May 06, 2013 at 04:46:11PM -0700, Tony Lindgren wrote:
> > Vaibhav Hiremath (1):
> >       ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a
> 
> Neither your pull request subject nor the above summary line really
> sum up what the problem is - the real problem is "fix breakage causing
> OMAP to fail to boot".
> 
> I've just been chasing this problem and the descriptions given on this
> just suggest that it's a timer issue not a non-boot issue.

Oops yes sorry if the description was a bit unclear.

Regards,

Tony
