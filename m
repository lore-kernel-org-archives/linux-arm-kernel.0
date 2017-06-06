From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Jun 2017 22:00:37 +0800
Subject: [linux-sunxi] [PATCH v4 1/3] ASoC: sun8i-codec-analog: prepare a
 mixer control/widget/route set for V3s
In-Reply-To: <20170605132722.6459-2-icenowy@aosc.io>
References: <20170605132722.6459-1-icenowy@aosc.io>
 <20170605132722.6459-2-icenowy@aosc.io>
Message-ID: <CAGb2v65Dd+qZZjqrjC34o9kA8oiNGWXAVidXKJo3_WTyFwUc6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 9:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner V3s has an analog codec without MIC2 and Line In, which will
> need a special set of mixer controls/widgets/routes, otherwise meaningless
> controls will be exported to userspace and confuse the user.
>
> Add the special set, and use it when the SoC has no MIC2 and Line In.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
