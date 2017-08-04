From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Aug 2017 11:56:22 +0800
Subject: [linux-sunxi] [PATCH 03/13] drm: sun4i: add support for H3's TCON
In-Reply-To: <20170801131304.7741-4-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <20170801131304.7741-4-icenowy@aosc.io>
Message-ID: <CAGb2v65gxoQgcdhyZVWFNeKxUJj34FuN7EJx-a6DkquyQhLYRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 9:12 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
>
> Allwinner H3 has two special TCONs without channel 0.
>
> Add support for this kind of TCON.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Ideally you would split this into two patches. The first one would add
the quirks support for TCONs without channel 0. I can also use this for
the A80. The second would add the H3 TCON.

ChenYu
