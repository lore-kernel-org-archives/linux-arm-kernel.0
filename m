From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 27 May 2015 07:20:39 +1000
Subject: [NEXT REQUEST][PATCH] backlight: pwm: handle EPROBE_DEFER while
 requesting the PWM
In-Reply-To: <20150526073648.GB11677@x1>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
 <20150312090224.GC3314@x1> <20150525112718.5f7e2d7d@bbrezillon>
 <20150526073648.GB11677@x1>
Message-ID: <20150527072039.07aeea30@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, 26 May 2015 08:36:48 +0100 Lee Jones <lee.jones@linaro.org> wrote:
>
> It looks like my for-backlight-fixes branch isn't in -next.
> 
> Stephen, could you rectify that please?
> 
> M: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150527/1ea6990c/attachment-0001.sig>
