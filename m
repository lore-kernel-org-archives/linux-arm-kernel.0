From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 Jan 2018 22:50:15 +0800
Subject: [PATCH v2 10/12] drm/sun4i: backend: Use runtime_pm variant of
 atomic_commit_tail
In-Reply-To: <dc22ddb2833718f05a761cb35a4d5416c93fa7c6.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
 <dc22ddb2833718f05a761cb35a4d5416c93fa7c6.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64TZbN-PkTV6u=m453QWmJ9_tjy+n_+A_h4wfqWLJFe_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> During a hardware commit, the commit bit in the backend will only be
> cleared if the TCON is enabled. Use the runtime_pm variant of the
> atomic_commit_tail hook that makes sure that the CRTC, our TCON, is enabled
> when we perform an atomic_commit.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
