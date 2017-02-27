From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 27 Feb 2017 12:47:04 -0800
Subject: [Outreachy kernel] [PATCH] staging: bcm2835-audio: Fixed
 spacing around '&'
In-Reply-To: <954e0bc5-cd3c-c06f-dbfa-bed486b823c6@broadcom.com>
References: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
 <alpine.DEB.2.20.1702261901180.2056@hadrien>
 <1488134072.9188.3.camel@perches.com>
 <alpine.DEB.2.20.1702261956070.2056@hadrien>
 <1488137824.9188.7.camel@perches.com>
 <alpine.DEB.2.20.1702262038560.2056@hadrien>
 <1488146211.9188.10.camel@perches.com>
 <3ed05e4f-b00a-8a4b-f4f2-de23ff9b461e@broadcom.com>
 <alpine.DEB.2.20.1702270724430.2187@hadrien>
 <954e0bc5-cd3c-c06f-dbfa-bed486b823c6@broadcom.com>
Message-ID: <1488228424.5276.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-02-27 at 12:35 -0800, Scott Branden wrote:
> > 
> Hi Julia,
> 
> On 17-02-26 10:25 PM, Julia Lawall wrote:
> > 
> > If you consider that you are getting too much outreachy mail at the
> > moment, just let me know what subsystem you want me to add an
> > exception
> > for.
> 
> The emails seem to mostly be coming with bcm2835-audio.
> > 
> > thanks,
> > julia
> 
> Thanks,
> ? Scott

I submitted the driver to stagging, so I feel a bit responsible for
this.  

I personally don't mind e-mails like this since people have to get
started somehow, and e-mail is rather easy to ignore or delete...

Perhaps it would make sense to either update the maintainer list for
this driver or move the driver somewhere else in staging?  I was
looking at the maintainer list for bcm2835, and it already marks
vc04_services as part of the bcm2835 files.  Perhaps another mark
should be added or the driver moved under vc04_services?
