From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 25 May 2010 17:27:12 +0200
Subject: Git pull request: ARM LPC32XX architecture
In-Reply-To: <20100312210353.GB1146@n2100.arm.linux.org.uk>
References: <a08234131003121244t6f914926s3ea75e98c017686a@mail.gmail.com>
	<20100312210353.GB1146@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80AC2FF1AE8@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Sent: Friday, March 12, 2010 1:04 PM
> To: Kevin Wells
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Git pull request: ARM LPC32XX architecture
> 
> On Fri, Mar 12, 2010 at 12:44:54PM -0800, Kevin Wells wrote:
> > Hi Russell, please pull the reviewed LPC32xx arch files from the
> > Pengutronix GIT server at:
> >
> > 	git://git.pengutronix.de/git/ukl/linux-2.6.git wells/lpc32xx
> 
> FYI, I'm not pulling anything new until I've seen Linus take the stuff
> that's already queued up.
> 
> Linus has finally said that he will take the bits of the ARM merge
> which missed the truncated merge window, so that might be tomorrow.
> 
> However, what I do want to avoid this time around is having an
> excessive number of merge conflicts, which may require a pause to
> sort out (and I might ask people to bring their trees up to date
> first.)
> 

Hi Russell,

It's been a few months since I've posted this patch set and I'd still
like to get it pulled.

As of yesterday, the patchset still applies and works with the latest
release, although a 'slab.h' patch is needed for 1 file.

Can you pull the original series plus the slab.h patch? (breaks bisect)?
Or do you want the slab.h fix included in the correct order in the
Series to be bisect friendly?

Thanks,
Kevin Wells
NXP Semiconductors
