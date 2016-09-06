From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 23:13:53 +0800
Subject: [PATCH v2 3/9] drm/sun4i: backend: Handle the SAT
In-Reply-To: <20160906144620.6322-4-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-4-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66jKGUx=HA-d-hBK2yuwP2BuvKYokPu4Mu0OZ7cB5sXaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 10:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A33 has an block called SAT that is part of the backend that needs to
> be clocked and out of reset to be able for the backend to operate properly.
>
> Extend the binding to have the SAT resources listed, and claim them when
> the backend probes.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
