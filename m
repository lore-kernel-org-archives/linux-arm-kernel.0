From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jan 2013 16:09:37 -0500 (EST)
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <50EDD588.3040603@gmail.com>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <201301091843.48942.arnd@arndb.de>
 <alpine.LFD.2.02.1301091349390.6300@xanadu.home>
 <201301092022.49130.arnd@arndb.de> <50EDD588.3040603@gmail.com>
Message-ID: <alpine.LFD.2.02.1301091603230.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Rob Herring wrote:

> That patch is already posted, but Russell doesn't like it as you can
> have a kernel that doesn't boot. You don't like the allno and randconfig
> failures, so we're stuck. I think there are dozens of config options
> that will make you not boot on any given platform, so failing to boot
> because you did not select your machine is a non-issue.

Rather than simply accept that "there are dozens of config options that 
will make you not boot on any given platform" and allow for this to be 
used as an argument for future sloppiness, I think we should consider 
fixing the config rules to avoid that situation as much as possible 
instead.


Nicolas
