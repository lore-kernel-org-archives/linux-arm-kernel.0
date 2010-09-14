From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 14 Sep 2010 16:05:02 +0200
Subject: [PATCH 2/9] Remove unused default configuration
In-Reply-To: <1284390832-7181-3-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-3-git-send-email-vince@kyllikki.org>
Message-ID: <20100914140502.GB10870@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

you seem to have missed to add mx1 to the subject.  This nearly made it
fall through my filter.  (It's a "manual" one that picks interesting
mails by looking at the subject.)

On Mon, Sep 13, 2010 at 04:13:45PM +0100, Vincent Sanders wrote:
> From: Vincent Sanders <vince@simtec.co.uk>
> 
> The mx1 default configuration has not built throughout the 2.6.36
> series (since 2.6.35-git1). The link has failed with
> 
> fs/built-in.o: In function `nfs_callback_authenticate':
> compr_zlib.c:(.text+0x7c12c): undefined reference to `svc_gss_principal'
> 
> This configuration appers to be unused by the maintainer so remove it.
NACK.  This build failure was reported with a patch proposal at Aug 25
that is a week after it was pulled into Linus' tree which IMHO is fast
enough considering that the breakage isn't mx1 related at all.  Up to
now it didn't result in a patch that was accepted into Linus' tree
though.

The full discussion can be found at

	http://thread.gmane.org/gmane.linux.kernel/1027380

s/appers/appears/ BTW

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
