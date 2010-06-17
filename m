From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jun 2010 19:40:22 +0100
Subject: [PATCH] MAINTAINERS: Change BCMRING maintainer
In-Reply-To: <8628FE4E7912BF47A96AE7DD7BAC0AADDDC69DDF19@SJEXCHCCR02.corp.ad.broadcom.com>
References: <8628FE4E7912BF47A96AE7DD7BAC0AADDDC694E3F7@SJEXCHCCR02.corp.ad.broadcom.com>
	<AANLkTil6o6tHQdDM0YQRgxme3VLVuk8HUOzqscxsBQBi@mail.gmail.com>
	<1276655981.1586.172.camel@Joe-Laptop.home>
	<AANLkTilI2toj42vZcHzPC4ru82CDMf2UWsTasPyOD3Nh@mail.gmail.com>
	<8628FE4E7912BF47A96AE7DD7BAC0AADDDC694E57D@SJEXCHCCR02.corp.ad.broadcom.com>
	<AANLkTink0mz5pS-QE0v7-_xXl_SXhY_Bx9ZH0PGUlUiz@mail.gmail.com>
	<8628FE4E7912BF47A96AE7DD7BAC0AADDDC69DDF19@SJEXCHCCR02.corp.ad.broadcom.com>
Message-ID: <20100617184022.GA7973@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 10:14:57AM -0700, JD (Jiandong) Zheng wrote:
> I know it is better to use git to create patch in the future and seems 
> I just need to clone linus' release tree 
> (git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git) 
> instead of arm linux tree (linux-arm.org/linux-2.6-stable.git) to 
> make change and create patches, is this correct understanding?

Note that the linux-arm tree is ARM Ltd's tree, and isn't a tree which
feeds directly into Linus' tree.  You can find that via
http://www.arm.linux.org.uk/developer/ but I suggest that you use
Linus' tree as a base line unless I have something which conflicts
in my tree.

I maintain three primary branches:
- master, for stuff scheduled for -rc
- devel, for stuff scheduled for the next merge window, and is unstable
  (iow, commits don't have a stable ID, so it is inadvisable to base
   work off this.)
- devel-stable, for stuff scheduled for the next merge window, where the
  commits are immutable.
