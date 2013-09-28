From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 Sep 2013 00:52:49 -0300
Subject: [RFC PATCH] imx: video: staging: Add HDMI support to imx-drm
 driver
In-Reply-To: <52069F7C.9050600@prisktech.co.nz>
References: <1375645673-18237-1-git-send-email-linux@prisktech.co.nz>
 <CAOMZO5CGpdD-iSVBc_dCvCFPXnRuP8PEBRi=xUEcOGwNubX3GQ@mail.gmail.com>
 <52069F7C.9050600@prisktech.co.nz>
Message-ID: <CAOMZO5ATJr24zVJXBLaje2M1TiQQb5D_oHjw=b855Ym07wG=5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

[Fix ARM kernel mailing list address that was wrong in your first email]

On Sat, Aug 10, 2013 at 5:15 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On 11/08/13 05:52, Fabio Estevam wrote:

> Thanks for the review.. Most of this is expected. I hadn't spent a lot of
> time tidying up or 'formalizing' the patch, but I will tidy up the comments
> you made.
>
> Three problem's I have noticed with the driver are:
>
> 1) If I start the system with no output connected, then connect the hdmi,
> the framebuffer is initialized in 1024x768, but the connector/encoder is in
> 1920x1080 (as per the video= kernel param).
>
> 2) The PLL fails to lock several times during startup, but always seems to
> be ok to initialize the actually requested mode.
>
> 3) EDID reading fails occassionally for no obvious reason. Powering down the
> Wandboard (sometimes several times) and it comes right.
>
> Once I get all this sorted out, and the code tidied up properly I will send
> a 'proper' patch.

Do you still plan to submitting the HDMI driver for mx6?

Regards,

Fabio Estevam
