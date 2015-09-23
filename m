From: codekipper@gmail.com (Code Kipper)
Date: Wed, 23 Sep 2015 20:41:15 +0200
Subject: [linux-sunxi][alsa-devel][PATCH 0/3]Add SPDIF support for
 Allwinner SoCs
In-Reply-To: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
Message-ID: <CAEKpxB=9nX6W7xpuQN5naqkkyEG-tkttfmFfs1JNgvpz=_UpEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
I'm getting a "fatal: 'send-email'" response with the last patch(even
though the dry run of the patch series worked) and I've not been able
to work around it. I'll post it as soon as I can work out what the
issue is,
BR,
CK

On 23 September 2015 at 20:04,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> This patch set adds support for the Allwinner SPDIF transceiver as present
> on the A10, A20 and A31 SoC boards.
>
> For now just the SPDIF transmitter has been tested on a Mele A2000.
>
> In order for this patch set to be functional we require audio clock patches
> which will be delivered separately. For those that are interested I've pushed
> the patches here with all the required changes to get SPDIF audio out of the
> device.
>
> https://github.com/codekipper/linux-sunxi/commits/spdif_delivery
>
> Thanks in advance,
> CK
>
> Marcus Cooper (3):
>   dt-bindings: add sunxi SPDIF transceiver bindings
>   dt-binding: Add sunxi SPDIF machine driver
>   ASOC: sunxi: Add support for the spdif block
>
>  .../devicetree/bindings/sound/sunxi,spdif.txt      |  49 ++
>  .../bindings/sound/sunxi-audio-spdif.txt           |  36 +
>  sound/soc/sunxi/Kconfig                            |  10 +
>  sound/soc/sunxi/Makefile                           |   4 +
>  sound/soc/sunxi/sunxi-machine-spdif.c              | 110 +++
>  sound/soc/sunxi/sunxi-spdif.c                      | 801 +++++++++++++++++++++
>  6 files changed, 1010 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
>  create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c
>  create mode 100644 sound/soc/sunxi/sunxi-spdif.c
>
> --
> 2.5.3
>
