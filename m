From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 23:10:38 +0800
Subject: [PATCH v2 4/9] drm/sun4i: Add a DRC driver
In-Reply-To: <20160906144620.6322-5-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-5-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67DFyx7wYLB0dn7zF0EzD+0s=1Kg2PJq1tNy_3gTUiuCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 10:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A33 pipeline also has a component called DRC. Even though its exact
> features and programming model is not known (or documented), it needs to
> be clocked for the pipeline to carry the video signal all the way.
>
> Add a minimal driver for it that just claim the needed resources for the
> pipeline to operate properly.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
