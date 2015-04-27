From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Mon, 27 Apr 2015 12:19:52 +0300
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <1430118452.1475.0@mail.essensium.com>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <1427876156.24886.1.camel@pengutronix.de>
 <1427877126.2449.0@mail.essensium.com>
 <CABH3fy_YWYoQZL4E_i1FWaY+rOgidxBVcUNo15GrXfcoS2or0A@mail.gmail.com>
 <1429878521.2872.3.camel@pengutronix.de>
 <CABH3fy8o8R7d+bpyxS-Q0eSyPgqg0dvuQnF7m1gywLAzjRBXRA@mail.gmail.com>
 <1430118452.1475.0@mail.essensium.com>
Message-ID: <CABH3fy-kaEuwW6oxwZgahopPEUheXtwbJRyUk2_9J0mqo89Pzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Catalin,
>
> Sorry for not being able to answer earlier.  Great that you made eMMC to
> work.  Can you share your pinmux configuration for usdhc3, so I can send a
> follow-up patch?

I have changed the byte 0x59 with 0x09
0x17059 -> 0x17009
and 0x10059 -> 0x10009
