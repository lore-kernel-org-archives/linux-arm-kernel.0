From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 26 Aug 2016 15:04:38 +0800
Subject: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160826065312.26803-2-dannym@scratchpost.org>
References: <20160826065312.26803-1-dannym@scratchpost.org>
 <20160826065312.26803-2-dannym@scratchpost.org>
Message-ID: <CAGb2v678PkvxM+8bvbmywFt1JZqqC+J8d1ZAvg_rKRs9UWgBfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 2:53 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
>
> This distinguishes sun4i from sun7i. It is necessary because they use
> different registers for the audio mixer.
> ---
>  sound/soc/sunxi/sun4i-codec.c | 44 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)
>

Please send your patches inline.

ChenYu
