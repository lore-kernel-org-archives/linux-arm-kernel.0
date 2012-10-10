From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 10:34:04 +0200
Subject: [PATCH v2] ARM : i.MX27 : split code for allocation of
 ressources of camera and eMMA
In-Reply-To: <5074202F.2020107@gmail.com>
References: <1346843175-4166-1-git-send-email-gcembed@gmail.com>
 <20120911094748.GS18243@pengutronix.de>
 <CACKLOr11UbRF3cyKZ5p_9K81=KS=AQxQNZv1YmxtC0kJeoz1+g@mail.gmail.com>
 <20120911111738.GU18243@pengutronix.de>
 <5074202F.2020107@gmail.com>
Message-ID: <20121010083404.GP27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 03:01:35PM +0200, Ga?tan Carlier wrote:
> Hi Sascha,
> On 09/11/2012 01:17 PM, Sascha Hauer wrote:
> >On Tue, Sep 11, 2012 at 01:13:03PM +0200, javier Martin wrote:
> >>Hi,
> >>
> >>On 11 September 2012 11:47, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >>>Hi Javier,
> >>>
> >>>Since you worked in this area recently, can I have your Ack on this?
> >>
> >>Acked-by: Javier Martin <javier.martin@vista-silicon.com>
> >
> >Thanks
> This patch is missing in next-20121008 and seems to be never
> committed. Is there any reason ?

Sorry, I simply missed to apply it :(

Did that now.

Sascha

> >
> >>
> >>>As a side note: Please be prepared that all this should be removed in
> >>>the not-so-far future. It would be good if you start converting your
> >>>boards to devicetree soon. You may be doing so internally already, I
> >>>don't know.
> >>
> >>We made some tests regarding devicetree this summer but we found that
> >>there are some things missing yet:
> >>- pinctrl
> >>- soc-camera and video sensor
> >>
> >>I don't know if people from Linaro is planning to deal with pinctrl
> >>for i.MX27 or not.
> >
> >I don't think Linaro will do anything for the older i.MX like the
> >i.MX27. With soc-camera I'm optimistic that someone will come up
> >with patches soon.
> >
> >Sascha
> >
> Thank you.
> Best regards,
> Ga?tan Carlier.
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
