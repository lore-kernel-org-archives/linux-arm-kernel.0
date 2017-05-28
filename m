From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 28 May 2017 22:55:11 +0800
Subject: [PATCH v4 06/11] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <288881a7a27fbf9f0ca20ad574314c537b975560.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
 <288881a7a27fbf9f0ca20ad574314c537b975560.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65zW-e1LaRbqgjBFpTLV-2crg997miakqCYEooztb3aFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 28, 2017 at 12:09 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> It appears that the total vertical resolution needs to be doubled when
> we're not in interlaced. Make sure that is the case.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
