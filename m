From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Oct 2016 10:49:58 +0800
Subject: [PATCH 3/6] ARM: sun5i: Rename A10s pins
In-Reply-To: <926093bcce58496cdb5cea55aaa65e958d36cb76.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
 <926093bcce58496cdb5cea55aaa65e958d36cb76.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64CLRf-Stqt7mJMM3h_aCMpD2bVB=Zi6fwsJ_8y5K9VhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 7:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The SPI2 pins on the sun5i PB bank are only available on the A10s. Rename
> the A10s only bank so that it doesn't confuse people on the other SoCs
> whose indexing would start at b.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
