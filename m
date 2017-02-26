From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 26 Feb 2017 19:59:16 +0100 (CET)
Subject: [Outreachy kernel] [PATCH] staging: bcm2835-audio: Fixed spacing
 around '&'
In-Reply-To: <1488134072.9188.3.camel@perches.com>
References: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
 <alpine.DEB.2.20.1702261901180.2056@hadrien>
 <1488134072.9188.3.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1702261956070.2056@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sun, 26 Feb 2017, Joe Perches wrote:

> On Sun, 2017-02-26 at 19:03 +0100, Julia Lawall wrote:
> >
> > On Sun, 26 Feb 2017, Narcisa Ana Maria Vasile wrote:
> >
> > > This was reported by checkpatch.pl
> > >
> > > Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> >
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> >
> > Actually, the outreachy tutorial says not to send patches to mailing
> > lists, only to people (except in the case of IIO, where the maintainers
> > asked for patches to be sent to mailing lists as well).  The
> > get_maintainer command to use is shown here:
> >
> > https://kernelnewbies.org/FirstKernelPatch#submit_a_patch
>
> That doesn't make any sense to me.
> Mailing lists _should_ be copied on patch submissions.

The idea of outreachy is that it should be a place for people to get
started without too much criticism from the outside.  Originally, only the
outreachy mailing list received patches.  But staging maintainers were
confused to have their drivers receiving patches that they had not seen.
So we expanded it to maintainers.

>
> And the displayed output of that command-line does not match
> the actual behavior.
>
> The command-line is:
> $ perl scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats --nol -f drivers/staging/most/aim-sound/sound.c
>
> And the output shown is:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>,devel at driverdev.osuosl.org,linux-kernel at vger.kernel.org
>
> That's not what's actually output by that command-line
> as it would not show the mailing list.
>
> $ perl scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats --nol -f drivers/staging/most/aim-sound/sound.c
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for the report, I will fix the output.

julia

> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe at googlegroups.com.
> To post to this group, send email to outreachy-kernel at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1488134072.9188.3.camel%40perches.com.
> For more options, visit https://groups.google.com/d/optout.
>
