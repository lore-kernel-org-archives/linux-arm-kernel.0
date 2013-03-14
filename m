From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 14 Mar 2013 13:44:50 +0100
Subject: [PATCH 01/10] imx-ssi: Fix AC97 rates
In-Reply-To: <CAOZdJXXm=jJv3zyD4j11t3BgNGyKz6V9jzShQLTk-BTiwDjvMg@mail.gmail.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5A8F81PzCjKHrkZ_AtGMr341d6OmYHMQvdzgunmGFDVsw@mail.gmail.com>
 <20130311195108.GC18350@pengutronix.de>
 <CAOZdJXXm=jJv3zyD4j11t3BgNGyKz6V9jzShQLTk-BTiwDjvMg@mail.gmail.com>
Message-ID: <20130314124450.GC32452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 05:55:24PM -0500, Timur Tabi wrote:
> On Mon, Mar 11, 2013 at 2:51 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> >
> > At the moment fsl-ssi and imx-ssi don't seem to have very much in
> > common. However I could try to merge the imx-ssi driver code into
> > fsl_ssi and make it handle imx27-ssi differently.
> 
> imx-ssi is the legacy driver that supports older, non-DT IMX platforms.
> fsl-ssi is the "new" driver that supports PowerPC and IMX DT-enabled platforms.

Okay, I will use the fsl-ssi driver then.

Thanks

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
