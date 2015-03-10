From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 15:52:29 +0100
Subject: [PATCH v2 3/3] ARM: mx25: Remove platform code support files
In-Reply-To: <CAOMZO5BC-pebQfbFhKBJAXto=6f6osHRW4V0kwvLJqzFuQVUqQ@mail.gmail.com>
References: <1425662758-4675-1-git-send-email-festevam@gmail.com>
 <21909740.nfZYRJLb3G@wuerfel>
 <CAOMZO5BC-pebQfbFhKBJAXto=6f6osHRW4V0kwvLJqzFuQVUqQ@mail.gmail.com>
Message-ID: <7138524.8fPsXzMqGK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 22:51:53 Fabio Estevam wrote:
> Hi Arnd,
> 
> On Mon, Mar 9, 2015 at 6:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Very nice, good to see some progress on the old machines!
> >
> > If you find the time, could you summarize your plans for the remaining
> > i.MX SoCs that have board files (imx21, imx27, imx31, imx35)? Do you plan
> > to continue with those, one by one?
> 
> After this series gets applied I will submit another one removing the
> remaining mx25 leftovers pieces.
> 
> mx27 can be the next one to be converted to dt-only (still need to get
> ov2640 camera, mc13783 audio and LCD to work in imx27-pdk.dts though).
> 
> mx35 should also be simple to convert to dt-only.
> 
> mx31 still lacks pinctrl.
> 
> I don't have access to imx1/imx21 hardware.
> 
> Hopefully someday we can get imx to be dt-only.
> 

Ok, thanks a lot for the update.

For imx21, we only support the original development board and no real
products, which means the platform code is not very valuable and we could
drop that if everything else is done.

For imx1, Alexander Shiyan has already submitted a series to remove
the board files. I don't know remember if there were remaining objections
to that, but it does seem reasonable.

	Arnd
