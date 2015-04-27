From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Mon, 27 Apr 2015 09:47:46 +0300
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <1429878521.2872.3.camel@pengutronix.de>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <1427876156.24886.1.camel@pengutronix.de>
 <1427877126.2449.0@mail.essensium.com>
 <CABH3fy_YWYoQZL4E_i1FWaY+rOgidxBVcUNo15GrXfcoS2or0A@mail.gmail.com>
 <1429878521.2872.3.camel@pengutronix.de>
Message-ID: <CABH3fy8o8R7d+bpyxS-Q0eSyPgqg0dvuQnF7m1gywLAzjRBXRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Fri, Apr 24, 2015 at 3:28 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Catalin,
>
> This may as well be a signaling issue. You could try to slow down the
> the MMC bus speed or play a bit with the pin drive strength values. Note
> that in those cases _reducing_ the drive strength may be the right thing
> to do.
>

Thank you!
I have managed to get it working after changing the drive strength to
260 Ohm and speed to 50 MHz.
Changing only the speed to 50 MHz didn't work, I had to also change
the drive strength. I haven't tested other values.
Maybe this can be pushed to mainline?

> Regards,
> Lucas

Best regards,
Catalin
