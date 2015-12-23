From: v1ron@mail.ru (Roman Volkov)
Date: Thu, 24 Dec 2015 00:48:25 +0300
Subject: [PATCH v3 0/2] WM8505/WM8650 DT fixes for SD card controller
In-Reply-To: <20150404152720.1059e741@v1ron-s7>
References: <1423130878-3894-1-git-send-email-v1ron@v1ros.org>
 <1425226007-2757-1-git-send-email-rvolkov@v1ros.org>
 <2119510.55A8Br1LeL@wuerfel> <20150301233911.2352ce48@v1ron-s7>
 <20150404152720.1059e741@v1ron-s7>
Message-ID: <20151224004825.4350790e@anonymous>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? Sat, 4 Apr 2015 15:27:20 +0300
Roman Volkov <v1ron@v1ros.org> ?????:

> ? Sun, 1 Mar 2015 23:39:11 +0300
> Roman Volkov <rvolkov@v1ros.org> ?????:
> 
> > ? Sun, 01 Mar 2015 20:52:55 +0100
> > Arnd Bergmann <arnd@arndb.de> ?????:
> >   
> > > On Sunday 01 March 2015 19:06:45 Roman Volkov wrote:  
> > > > This patch set enables SD controller support for WM8650 and
> > > > fixes minor errors in WM8505 Device Tree file.
> > > > 
> > > > Changes in v3:
> > > > 1. Add minor fixes for WM8505 SDHC node
> > > > 
> > > > Tested on both WM8505 and WM8650.
> > > > 
> > > > Roman Volkov (2):
> > > >   dts: vt8500: Add SDHC node to DTS file for WM8650
> > > >   dts: vt8500: Fix errors in SDHC node for WM8505
> > > > 
> > > >  arch/arm/boot/dts/wm8505.dtsi | 4 ++--
> > > >  arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
> > > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > > > 
> > > > -- 
> > > > Hi maintainers, I see my previous versions were not applied.
> > > > Could this little patch set be applied for the linux-next? I
> > > > don't think this is new functionality, this must be considered
> > > > as bugfix for existing Device Tree.
> > > > 
> > > > Any other suggestions?  
> > > 
> > > According to the MAINTAINERS file, Tony Prisk should be the person
> > > to pick them up, but he was not the recipient of the mail.
> > > 
> > > 	Arnd  
> > 
> > Thanks for the tip. Tony probably need to add these files to his
> > list of maintained files. get_maintainer.pl doesn't mention him.
> > 
> > Roman  
> 
> Arnd,
> 
> No response yet from Tony for over a month.
> 
> Roman

Ping. At least two patch sets for vt8500 are waiting to be picked up.
vt8500 maintainer is inactive for over a year.

Regards,
Roman
