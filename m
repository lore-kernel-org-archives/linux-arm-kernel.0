From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 00:05:18 +0800
Subject: [PATCH 03/20] clk: sunxi: tcon-ch1: Do not return a negative
 error in get_parent
In-Reply-To: <1463402840-17062-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64GxTFnnx40Jy9Cz9e+c+T2j2QcbFznZ4-Lm-tdHFgcXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> get_parent is supposed to return an unsigned 8 bit integer, so returning
> -EINVAL is a bad idea.
>
> Remove it.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
