From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 17:50:09 +0200
Subject: [PATCH 0/1] A trio of IXP425 boards
In-Reply-To: <20111007061918.GA2229@netboy.at.omicron.at>
References: <cover.1317215339.git.richard.cochran@omicron.at>
	<m3obxv7fvy.fsf@intrepid.localdomain>
	<20111007061918.GA2229@netboy.at.omicron.at>
Message-ID: <201110071750.09200.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011, Richard Cochran wrote:
> On Wed, Oct 05, 2011 at 03:00:01PM +0200, Krzysztof Halasa wrote:
> > Richard Cochran <richardcochran@gmail.com> writes:
> > 
> > > This patch adds support for three boards using the ixp425. Since they
> > > are are almost identical to each other, they can share one setup file.
> > >
> > > The three machine types are slated for removal due to the fact that
> > > the board support has not been merged. My polite request is to merge
> > > this patch and restore the machine types.
> > 
> > This is a good idea, IMHO.
> > Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>
> > 
> > Unfortunately ATM I don't have access to kernel.org and being a bit
> > busy with unrelated things, I'd rather avoid "processing" this patch
> > personally if possible. Can you send it upstream yourself, please?
> > Let me know of any problem.
> 
> Okay, then, Arnd? Russell?
> 
> Will one of you please take this patch?

Sorry I forgot to notify you. I had already taken the patch on monday,
but it did not show up in linux-next because an unrelated change broke
the build. It should be fixed now.

	Arnd
