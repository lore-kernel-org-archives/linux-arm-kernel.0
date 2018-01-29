From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 29 Jan 2018 09:52:57 +0800
Subject: [PATCH v2 12/19] drm/sun4i: backend: Move the coord function in
 the shared part
In-Reply-To: <2cd57bcf13652109da7bd5bbe12fa1d29429f02f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
 <2cd57bcf13652109da7bd5bbe12fa1d29429f02f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64BL31Y8s-0H62uXfpZVC049-o-SZqHEZ=D4=Tf5QT1kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 6:35 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The function supposed to update a plane's coordinates is called in both
> branches of our function. Let's move it out the if statement.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
