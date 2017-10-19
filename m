From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Oct 2017 15:40:24 +0800
Subject: [linux-sunxi] [PATCH v2 5/5] ARM: sun8i: v40: enable USB host
 ports for Banana Pi M2 Berry
In-Reply-To: <20171018130628.11298-6-icenowy@aosc.io>
References: <20171018130628.11298-1-icenowy@aosc.io>
 <20171018130628.11298-6-icenowy@aosc.io>
Message-ID: <CAGb2v64njU6BRTA6Hq=B6U58aCJk+kDD9OUch+YdqbDN8JgeeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 18, 2017 at 9:06 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
> ports, and it's connected to the USB1 port of the SoC.
>
> Enable it.

What is the USB hub chip's model? If it's a USB 2.0 hub, then you
don't need to enable the OHCI.

ChenYu
