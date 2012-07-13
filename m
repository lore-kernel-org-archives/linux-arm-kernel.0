From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jul 2012 16:44:02 +0000
Subject: [GIT PULL] DaVinci DT support for v3.6
In-Reply-To: <50003C21.9080500@ti.com>
References: <50003C21.9080500@ti.com>
Message-ID: <201207131644.02961.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012, Sekhar Nori wrote:
> Hi Arnd, Olof,
> 
> Can you please pull the following patch adding DT support for DaVinci 
> for v3.6?
> 
> Sorry for the late request, I was waiting for an ack from either Grant 
> or Rob but looks like both are busy. Grant has reviewed earlier versions
> of the patch.
> 
> This pull request depends on DaVinci SoC updates pulled earlier.
> 

Pulled, thanks!

I'm a bit surprised to see DT support series for davinci when the platform
doesn't support DT booting and the series doesn't add it, but I suppose
you're still working on other parts.

>From what I can tell, this is the second out of seven patches from Heiko,
where the first one was part of the initial set. Are you planning to submit
the others for 3.6 still, or is this for after the merge window?

	Arnd
