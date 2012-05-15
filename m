From: alior@marvell.com (Lior Amsalem)
Date: Tue, 15 May 2012 15:26:52 +0300
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB23B9F.6040708@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB23B9F.6040708@codethink.co.uk>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C34@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ben Dooks [mailto:ben.dooks at codethink.co.uk]
> Sent: Tuesday, May 15, 2012 2:19 PM
> To: Thomas Petazzoni
> Cc: Arnd Bergmann; Olof Johansson; Lior Amsalem; Andrew Lunn; Jason
> Cooper; Nicolas Pitre; Maen Suleiman; Ben Dooks; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: Add basic support for new Marvell Armada SoC
> family
> 
> On 15/05/12 09:54, Thomas Petazzoni wrote:
[snip]

> >
> > The patch set is based on your arm-soc/for-next branch.
> 
> Is there a git tree that can be pulled from?
https://github.com/Marvell-Semi/EBU_mainline_public/tree/for-next

> 
> > We intend to quickly build on top of this initial support with the
> > following elements:
> >
> >   * Usage of the clock framework
> 
> I'd say that was a pretty important part even if it just a couple of static clocks
> for the tclk and fabric clock.
> 
It's one of our tasks list, should be ready soon.

> >
> > Best regards,
> >
> > Thomas Petazzoni
> 
> 
> --
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius

Lior Amsalem
