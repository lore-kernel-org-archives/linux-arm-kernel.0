From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 May 2013 09:12:11 +0100
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <CACRpkda3d9_XvqRmy0nbWyri2xC3Qst2U2Sv=UDxV4w-UxK_JQ@mail.gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <20130529175741.GG21290@arwen.pp.htv.fi>
 <CACRpkda3d9_XvqRmy0nbWyri2xC3Qst2U2Sv=UDxV4w-UxK_JQ@mail.gmail.com>
Message-ID: <20130530081211.GA1915@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Linus Walleij wrote:

> On Wed, May 29, 2013 at 7:57 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Wed, May 15, 2013 at 10:51:43AM +0100, Lee Jones wrote:
> >> For all ux500 based platforms the maximum number of end-points are used.
> >> Move this knowledge into the driver so we can relinquish the burden from
> >> platform data. This also removes quite a bit of complexity from the driver
> >> and will aid us when we come to enable the driver for Device Tree.
> >>
> >> Cc: Felipe Balbi <balbi@ti.com>
> >> Cc: linux-usb at vger.kernel.org
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > for drivers/usb/musb
> >
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Is that only for this patch 20/39 or also 21, 22 & 23?
> 
> Poke us if we should re-send them...

I read this as all patches in the series "for drivers/usb/musb".

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
