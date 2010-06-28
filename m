From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 28 Jun 2010 10:47:26 -0700 (PDT)
Subject: [PATCH] mx31_3ds: Allow selection between host/device modes on
	the OTG port
In-Reply-To: <4C239E81.4040805@gmail.com>
Message-ID: <538995.53508.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

--- On Thu, 6/24/10, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> From: Magnus Lilja <lilja.magnus@gmail.com>
> Subject: Re: [PATCH] mx31_3ds: Allow selection between host/device modes on the OTG port
> To: "Fabio Estevam" <fabioestevam@yahoo.com>
> Cc: linux-arm-kernel at lists.infradead.org, s.hauer at pengutronix.de, maramaopercheseimorto at gmail.com
> Date: Thursday, June 24, 2010, 3:05 PM
> Hi Fabio,
> 
> On 2010-06-23 22:52, Fabio Estevam wrote:
> > Allow selection between host/device modes on the OTG
> port.
> > 
> > Selection is made via kernel command line option:
> > 
> > 'otg_mode=host' or 'otg_mode=device'. Default mode is
> device.
> 
> 
> Would it be possible to select between host and device
> during run-time, e.g. when the USB modules are loaded? I'm
> asking out of curiosity, I don't know if Linux supports this
> at all.

Not sure if would be possible to make the selection in run-time. 

I will let others comment.

Sascha,

I will resend this patch based on the current imx-for-2.6.26 branch.

Regards,

Fabio Estevam


      
