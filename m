From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Mar 2017 19:47:23 +0800
Subject: [PATCH v3 3/5] ASoC: sun8i-codec: Fix space on audio-routing
 widget
In-Reply-To: <20170318075509.3836-4-mylene.josserand@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-4-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v65f2jGog41HAV3p2i9PTZkzFbifqCzX+SXZ1jaOTN4V4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 3:55 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> An unwanted space is present in an audio widget's name on the dapm
> routing. It causes an error on the recognition of this widget (error:
> ("no dapm match for AIF1 Slot 0 Right").
>
> Remove the space fixes it.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

As mentioned, this patch can be squashed into the previous patch, now
that you're resending the whole bunch of patches.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
