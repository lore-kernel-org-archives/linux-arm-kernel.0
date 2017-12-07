From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 7 Dec 2017 12:02:49 +0800
Subject: [PATCH v3 10/15] ARM: dts: sun8i: a83t: Add display pipeline
In-Reply-To: <97d3cee9d0d7a92893f646d72643bac520de5f05.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <97d3cee9d0d7a92893f646d72643bac520de5f05.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67XRO=C21AE2ZGK9zc5yQE5H4fMm3Gv6ZTwBUyOEDOoOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 11:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The display pipeline on the A83T is mainly composed of the mixers and
> TCONs, plus various encoders.
>
> Let's add the first mixer and TCON to the DTSI since the only board I have
> can use only the LVDS output on the first TCON. The other parts will be
> added eventually.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
