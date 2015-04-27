From: vianney.leclement@essensium.com (Vianney le =?iso-8859-1?q?Cl=E9ment?=)
Date: Mon, 27 Apr 2015 09:07:32 +0200
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <CABH3fy8o8R7d+bpyxS-Q0eSyPgqg0dvuQnF7m1gywLAzjRBXRA@mail.gmail.com>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <1427876156.24886.1.camel@pengutronix.de>
 <1427877126.2449.0@mail.essensium.com>
 <CABH3fy_YWYoQZL4E_i1FWaY+rOgidxBVcUNo15GrXfcoS2or0A@mail.gmail.com>
 <1429878521.2872.3.camel@pengutronix.de>
 <CABH3fy8o8R7d+bpyxS-Q0eSyPgqg0dvuQnF7m1gywLAzjRBXRA@mail.gmail.com>
Message-ID: <1430118452.1475.0@mail.essensium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 8:47 , Catalin Crenguta 
<catalin.crenguta@gmail.com> wrote:
> I have managed to get it working after changing the drive strength to
> 260 Ohm and speed to 50 MHz.
> Changing only the speed to 50 MHz didn't work, I had to also change
> the drive strength. I haven't tested other values.
> Maybe this can be pushed to mainline?

Hi Catalin,

Sorry for not being able to answer earlier.  Great that you made eMMC 
to work.  Can you share your pinmux configuration for usdhc3, so I can 
send a follow-up patch?

Thanks,
Vianney

Vianney le Cl?ment de Saint-Marcq
Embedded Software Developper ? +32 485 84 55 05
Essensium, Mind division ? www.mind.be
GPG: 727B CFE9 355F 1B02 0820 EE1C 9042 3E07 A804 0316
