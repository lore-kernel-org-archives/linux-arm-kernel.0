From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 May 2014 10:15:53 +0100
Subject: [linux-sunxi] Re: [PATCH v5 4/8] input: misc: Add driver for
 AXP20x Power Enable Key
In-Reply-To: <CAOQ7t2bPHnjfpeqQjMsYJs--qpd1_1RvBEFXztTDgnf5yW=Yxg@mail.gmail.com>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-5-git-send-email-carlo@caione.org>
 <20140503010604.GE4090@lukather>
 <20140519055745.GL29386@core.coreip.homeip.net>
 <CAOQ7t2bPHnjfpeqQjMsYJs--qpd1_1RvBEFXztTDgnf5yW=Yxg@mail.gmail.com>
Message-ID: <20140519091553.GC4978@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 May 2014, Carlo Caione wrote:

> On Mon, May 19, 2014 at 7:57 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Fri, May 02, 2014 at 06:06:04PM -0700, Maxime Ripard wrote:
> >> On Thu, May 01, 2014 at 02:29:30PM +0200, Carlo Caione wrote:
> >> > This patch add support for the Power Enable Key found on MFD AXP202 and
> >> > AXP209. Besides the basic support for the button, the driver adds two
> >> > entries in sysfs to configure the time delay for power on/off.
> >> >
> >> > Signed-off-by: Carlo Caione <carlo@caione.org>
> >>
> >> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > How are we merging it? MFD tree?
> 
> No idea. Lee, can you help in merging it?
> The only thing still  left out is the DT to be merged through Maxime
> (I need to submit a v6 only for that).

Yes.

Weren't you in receipt of my email sent out an hour before this one?

I thought you were re-sending the test though (v6?).

If you can set that, complete with all the Acks, I'd be much obliged.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
