From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 2 Sep 2016 09:47:06 +0800
Subject: [PATCH 1/7] drm/sun4i: support TCONs without channel 1
In-Reply-To: <20160901153204.11217-2-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-2-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67phF+AxN9jCoj_J7Sy=fDu22rWg=rDe7bqkAyMO4UU-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 11:31 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some Allwinner SoCs, such as the A33, have a variation of the TCON that
> doesn't have a second channel (or it is not wired to anything).
>
> Make sure we can handle that case.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
