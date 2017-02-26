From: joe@perches.com (Joe Perches)
Date: Sun, 26 Feb 2017 10:34:32 -0800
Subject: [Outreachy kernel] [PATCH] staging: bcm2835-audio: Fixed
 spacing around '&'
In-Reply-To: <alpine.DEB.2.20.1702261901180.2056@hadrien>
References: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
 <alpine.DEB.2.20.1702261901180.2056@hadrien>
Message-ID: <1488134072.9188.3.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-02-26 at 19:03 +0100, Julia Lawall wrote:
> 
> On Sun, 26 Feb 2017, Narcisa Ana Maria Vasile wrote:
> 
> > This was reported by checkpatch.pl
> > 
> > Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> Actually, the outreachy tutorial says not to send patches to mailing
> lists, only to people (except in the case of IIO, where the maintainers
> asked for patches to be sent to mailing lists as well).  The
> get_maintainer command to use is shown here:
> 
> https://kernelnewbies.org/FirstKernelPatch#submit_a_patch

That doesn't make any sense to me.
Mailing lists _should_ be copied on patch submissions.

And the displayed output of that command-line does not match
the actual behavior.

The command-line is:
$ perl scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats --nol -f drivers/staging/most/aim-sound/sound.c

And the output shown is:
Greg Kroah-Hartman <gregkh@linuxfoundation.org>,devel at driverdev.osuosl.org,linux-kernel at vger.kernel.org

That's not what's actually output by that command-line
as it would not show the mailing list.

$ perl scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats --nol -f drivers/staging/most/aim-sound/sound.c
Greg Kroah-Hartman <gregkh@linuxfoundation.org>
