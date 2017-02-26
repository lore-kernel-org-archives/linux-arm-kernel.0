From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 26 Feb 2017 14:06:06 +0800
Subject: [PATCH 2/9] ASoC: sun8i-codec-analog: split out linein and mic2
In-Reply-To: <20170225123029.55939-2-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
 <20170225123029.55939-2-icenowy@aosc.xyz>
Message-ID: <CAGb2v66Yhw1kxAzWE0RjUYe+reUswdw=3jx4MRErbjbGaMjtGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 8:30 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Allwinner V3s SoC features an analog codec without linein and mic2.
>
> Split out them, in order to prepare for the analog codec on V3s.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Though it would be better if you did 1 split as 1 patch, with 2 patches
in total.
