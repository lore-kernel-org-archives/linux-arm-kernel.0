From: alior@marvell.com (Lior Amsalem)
Date: Wed, 16 May 2012 17:55:27 +0300
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205161200.59362.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515164438.22258885@skate>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
 <201205161200.59362.arnd@arndb.de>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A581@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, May 16, 2012 3:01 PM
> To: Lior Amsalem
> Cc: Thomas Petazzoni; Rob Herring; Ben Dooks; Andrew Lunn; Jason Cooper;
> Nicolas Pitre; Maen Suleiman; Ben Dooks; Olof Johansson; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: Add basic support for new Marvell Armada SoC
> family
> 
[snip]
> 
> Thanks for the list, very helpful!
> 
> So do you think it makes sense to put all of these into mach-orion?
>
Well, Orion is old and seems like not the best name for a directory to include 
all the new platforms.
We are discussing it internally as well and I'll update with our suggestion.

> 
> Where does the Armada 1000/1500 (88DE3010/88DE3100) fit in here. Is it
> related to the EBU family above or the PXA/MMP family, or is it something
> entirely different?
> 
I only know general info, no more than what can be found in Marvell's site: 
http://www.marvell.com/digital-entertainment/

> Also, I've seen dove (Armada 510) being referred to as PXA510. Is that also an
> official designation or just a mistake made by people who were confused by
> the marketing names?
It was the SoC name at some point, the official name is Armada 510.

> 
> 	Arnd

Lior Amsalem
