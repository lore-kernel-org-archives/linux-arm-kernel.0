From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Nov 2010 12:59:01 +0000
Subject: [PATCH] [ARM] twd: Allow twd rescaling to match cpu frequency
In-Reply-To: <DB5ED9F94071134F8D813944A461CF1A0196031CBA@ESESSCMS0361.eemea.ericsson.se>
References: <1283396674-4865-1-git-send-email-ccross@android.com>
	<AANLkTinsRCinLdhq1xj0tx09Jb=Tohdbd7PUD=ae1q3m@mail.gmail.com>
	<DB5ED9F94071134F8D813944A461CF1A0196031CBA@ESESSCMS0361.eemea.ericsson.se>
Message-ID: <20101112125901.GA3619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 01:49:50PM +0100, Harald Gustafsson wrote:
> Hi,
> 
> Don't forget the other patches to make this work:
> 
> [ARM] twd: Always calibrate local timer
> [ARM] twd: Fix updating control register in set_mode
> [ARM] twd: Fix prescaler getting cleared by set_mode

... which have never been posted to this mailing list, so no one here
knows of them.
