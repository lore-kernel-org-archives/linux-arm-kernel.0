From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 11:59:24 +0200
Subject: [PATCH 0/3] arm: dts: lpc32xx: update ssp / spi nodes
In-Reply-To: <571838C5.4050102@mleia.com>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
 <1461158925.3004.3.camel@localhost> <571838C5.4050102@mleia.com>
Message-ID: <7082850.i7ZQLBP0Xs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 05:19:49 Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 20.04.2016 16:28, Sylvain Lemieux wrote:
> > Hi Vladimir,
> > 
> > On Mon, 2016-04-18 at 23:52 +0200, Arnd Bergmann wrote:
> >> On Monday 18 April 2016 17:22:28 Sylvain Lemieux wrote:
> >>> On Mon, 2016-04-18 at 07:45 +0300, Vladimir Zapolskiy wrote:
> >>>>> Once we have an agreement on who does this, please send a patch to
> >>>>> update the MAINTAINERS file.
> >>>>
> > Will you send a patch to update the MAINTAINERS file or do you want
> > me to send it?
> 
> I'll send to change, you'll be included as a maintainer, the record
> also needs some other updates, e.g. it is not about machine support
> but about SoC support etc.
> 
> Arnd, I'm not sure if MAINTAINERS update should go though a pull
> request (= no explicit SoB from an ARM maintainer) or if you expect
> to get a patch and apply it yourself, please advise.

Either way works. We tend to group MAINTAINER file updates with bugfixes,
so if you have any other fixes for 4.6 or 4.7, just throw it in the same
pull request you send us, otherwise send a separate patch.

> > Should we add the lpc32xx dts to the list of supported file?
> > 
> 
> There is a possibility to add files by regex, which makes sense
> to do after renaming dts files - this is in my first priority todo list.

The order is not important here, it's fine with me if you want to add
a regex for the new name even if the actual renaming is in a different
branch.

	Arnd
