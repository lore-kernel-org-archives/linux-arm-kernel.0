From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 12 Feb 2017 14:40:41 +0800
Subject: [PATCH 3/4] ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY
In-Reply-To: <20170210094133.11382-4-mylene.josserand@free-electrons.com>
References: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
 <20170210094133.11382-4-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v67sfVaJXYEwzX9c=5Lo0MjnEUcmWd+z_XHEnaSBsjqk7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 5:41 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> SOC_MIXER_ARRAY is a simplified function of SND_SOC_DAPM_MIXER
> which handles automatically the ARRAY_SIZE of controls.
>
> Update the driver to use SOC_MIXER_ARRAY.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
