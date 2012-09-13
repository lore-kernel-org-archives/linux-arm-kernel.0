From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 13 Sep 2012 07:00:54 +0000
Subject: [PATCH 02/16] ARM: davinci: move platform_data definitions
In-Reply-To: <201209121711.10715.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-2-git-send-email-arnd@arndb.de>
 <1BAFE6F6C881BF42822005164F1491C33EA802EC@DBDE01.ent.ti.com>
 <201209121711.10715.arnd@arndb.de>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA811E3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 22:41:09, Arnd Bergmann wrote:
> On Wednesday 12 September 2012, Hebbar, Gururaja wrote:
> > On Tue, Sep 11, 2012 at 18:29:36, Arnd Bergmann wrote:
> 
> > >  drivers/usb/musb/da8xx.c                                     |    2 +-
> > 
> > 
> > >  .../asp.h => include/linux/platform_data/asoc-davinci-evm.h  |    0
> > 
> > 
> > This will clash with patch "ASoC/ARM: Davinci: McASP: split asp header into 
> > platform and audio specific" queued in ASoC tree by Mark
> > 
> 
> Ok, I've taken out that hunk, this is the remaining patch. There will
> still be minor conflicts though, because it changes some adjacent lines.
> 
> 	Arnd

Thanks for the consideration.

> 
> 
..snip..
..snip..


Regards, 
Gururaja
