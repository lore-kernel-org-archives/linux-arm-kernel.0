From: cjb@laptop.org (Chris Ball)
Date: Mon, 22 Nov 2010 19:50:28 +0000
Subject: [PATCH v4 1/2] MMC: add support for the Marvell Dove SDHCI
	controller
In-Reply-To: <AANLkTi=sy51X-RVvUYBmoWfKfXBy2rWYshFtFMqt-fHh@mail.gmail.com>
References: <cover.1288293593.git.mike@compulab.co.il>
	<ea487c43c1aff1d07355e0e0699e739c8617b96f.1288293593.git.mike@compulab.co.il>
	<AANLkTimhzUe+qODZYCvvrH6Hi06gV1yHVpS1LRHhXu7o@mail.gmail.com>
	<AANLkTin66iEqCgUKUFXGLZg4pu-mv=zb-E+x04BrC-=h@mail.gmail.com>
	<AANLkTi=sy51X-RVvUYBmoWfKfXBy2rWYshFtFMqt-fHh@mail.gmail.com>
Message-ID: <20101122195028.GA25641@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad, Saeed,

On Mon, Nov 22, 2010 at 02:19:45PM +0200, saeed bishara wrote:
> >>> + ? ? ? ? If you have a controller with this interface, say Y or M here.
> >
> > Just a nitpick: ?I guess that the "or M" in "say Y or M" is a typo
>
> that's right, Mike, please remove the "or M"

Did this already, before merging the patch to mmc-next:

http://thread.gmane.org/gmane.linux.kernel.mmc/4321/focus=4437

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
