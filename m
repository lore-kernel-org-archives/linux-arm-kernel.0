From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 May 2017 15:46:36 +0800
Subject: [PATCH] arm64: allwinner: h5: Remove syslink to shared DTSI
In-Reply-To: <20170515085000.27965-1-maxime.ripard@free-electrons.com>
References: <20170515085000.27965-1-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67yp+GL+nMy7hSmFiccqnGjmdyfZMVnPXAGRqO8j7=R7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 4:50 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The arm64 H5 and arm H3 SoCs share roughly the same base, and therefore
> share a significant part of their device tree.
>
> The approach we took was to add a symlink from the arm64 DTSI to the arm
> DTSI.
>
> Now that the arm DT folder is exposed in the include path, we can just use
> it and remove our symlink.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
