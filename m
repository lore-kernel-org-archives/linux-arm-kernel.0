From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 12 Dec 2012 10:44:15 +0200
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <50C83EB1.5050509@pengutronix.de>
References: <50BE0CDB.5000704@pengutronix.de> <1355230894.19818.1.camel@hornet>
 <50C7386E.70305@pengutronix.de> <1355249468.19818.23.camel@hornet>
 <50C83EB1.5050509@pengutronix.de>
Message-ID: <20121212084414.GF18999@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Dec 12, 2012 at 09:22:09AM +0100, Marc Kleine-Budde wrote:
> On 12/11/2012 07:11 PM, Pawel Moll wrote:
> > On Tue, 2012-12-11 at 13:43 +0000, Marc Kleine-Budde wrote:
> >> What about putting the notes section into the read only segment, i.e.
> >> the ROM?
> > 
> > Could you, please, try the change below? It seems to do the job for me.
> 
> Works for me. The kernel image links to 640 KiB again.

Thant's the lowest figure I've ever seen for a kernel image. How do you get 
there?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
