From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Mar 2011 16:01:02 +0000
Subject: Newbies question: Which tree do I base my mc13783-regulator
	patches on?
In-Reply-To: <4D78F0D9.7070408@hale.at>
References: <4D78F0D9.7070408@hale.at>
Message-ID: <20110310160102.GE7411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 04:40:09PM +0100, Helmut Raiger wrote:
> I'm currently implementing the suspend functions of this regulator.

> Could anyone give me a quick start on how to submit the patches correctly?

Use git://git.kernel.org/pub/scm/linux/kernel/git/lrg/voltage-2.6

In general you'll usually be OK basing your work off -next without
worrying too much about individual trees as that includes the latest
development code for most of the kernel.  You can look up individual
trees in MAINTAINERS.
