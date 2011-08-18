From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2011 20:41:16 +0100
Subject: [PATCH] ARM: mmp: rename SHEEVAD to GPLUGD
In-Reply-To: <4E4CA5B3.3030706@einfochips.com>
References: <1313469117-7818-1-git-send-email-eric.y.miao@gmail.com>
	<4E4CA5B3.3030706@einfochips.com>
Message-ID: <20110818194116.GC28546@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A message to everyone.

Do not submit board support to mainline for which you haven't first
sorted out the mach-types stuff.  The mach-types database has been linked
into tracking what is in mainline for quite some time now, with the
purpose of locking out changes to the database against stuff already
included in mainline to prevent build breakages caused by stuff getting
changed after submission.

The side effect of that is that I _too_ get blocked from sorting it out
via the web interface, and have to resort to fiddling with the database
via SQL.

I am _NOT_ going to do that very often.  If you make me resort to it,
I will sort out those problems at my leisure, or more probably never.

You have been warned.
