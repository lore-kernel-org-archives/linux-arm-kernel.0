From: harald.gustafsson@ericsson.com (Harald Gustafsson)
Date: Fri, 12 Nov 2010 14:05:59 +0100
Subject: [PATCH] [ARM] twd: Allow twd rescaling to match cpu frequency
In-Reply-To: <20101112125901.GA3619@n2100.arm.linux.org.uk>
References: <1283396674-4865-1-git-send-email-ccross@android.com>
	<AANLkTinsRCinLdhq1xj0tx09Jb=Tohdbd7PUD=ae1q3m@mail.gmail.com>
	<DB5ED9F94071134F8D813944A461CF1A0196031CBA@ESESSCMS0361.eemea.ericsson.se>
	<20101112125901.GA3619@n2100.arm.linux.org.uk>
Message-ID: <2D4BBBBAD3C3714F8E8675F927E908210A210908@ESESSCMS0361.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Don't forget the other patches to make this work:
> > 
> > [ARM] twd: Always calibrate local timer [ARM] twd: Fix updating 
> > control register in set_mode [ARM] twd: Fix prescaler 
> getting cleared 
> > by set_mode
> 
> ... which have never been posted to this mailing list, so no 
> one here knows of them.

They are on the tegra branch git also authored by Colin. So I would suggest that Colin make all the changes into a new patch.

http://android.git.kernel.org/?p=kernel%2Ftegra.git&a=search&h=refs%2Fheads%2Flinux-tegra-2.6.35&st=commit&s=twd

/Harald
