From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 15:06:14 +0800
Subject: [PATCH v2 5/7] clk: sunxi-ng: Add A33 CCU support
In-Reply-To: <20160906121837.7517-6-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-6-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64Sviufr4j20W_GL6N87WSstsfnBqkU-4hovMigbHuhjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> This commit introduces the clocks found in the Allwinner A33 CCU.
>
> Since this SoC is very similar to the A23, and we share a significant share
> of the DTSI, the clock IDs that are going to be used will also be shared
> with the A23, hence the name of the various header files.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
