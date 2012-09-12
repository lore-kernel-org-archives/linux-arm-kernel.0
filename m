From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 12 Sep 2012 03:53:45 +0000
Subject: [PATCH 13/16] ARM: omap: move platform_data definitions
In-Reply-To: <201209111704.16708.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <CAMQu2gz8F2FcgRuok3x1uJ4pP8=0E2-9jhYGchzU9AUtUHjYhg@mail.gmail.com>
 <504F6249.2090501@ti.com> <201209111704.16708.arnd@arndb.de>
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB18FD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 22:34:16, Arnd Bergmann wrote:
> On Tuesday 11 September 2012, Vaibhav Hiremath wrote:
> > On 9/11/2012 7:54 PM, Shilimkar, Santosh wrote:
> > > On Tue, Sep 11, 2012 at 7:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > >> On Tuesday 11 September 2012, Shilimkar, Santosh wrote:
> > >>> Just curious to know how you came with some of the above header names ?
> > >>>
> > >>> plat/mcbsp ---> dsp-mcbsp.h
> > >>> There is no connection of DSP with McBSP. "omap-mcbsp.h" would been a
> > >>> better name.
> > >>
> > >> This one was a mistake on my side, as Tony and  Peter already pointed out.
> > >> How about asoc-mcbsp.h or asoc-omap-mcbsp.h?
> > >>
> > > After re-reading the cover-letter and your below response,
> > > 'asoc-omap-mcbsp.h' seems to be fine.
> > > 
> > 
> > Note that mcbsp is also applicable to Davinci family of devices.
> 
> asoc-ti-mcbsp.h then?
> 

Looks ok to me.

Thanks,
Vaibhav

> 	Arnd
> 
