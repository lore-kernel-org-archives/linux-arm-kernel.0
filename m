From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Jan 2017 16:04:38 +0800
Subject: [PATCH] regulator: axp20x: AXP806: Fix dcdcb being set instead of
 dcdce
In-Reply-To: <20170121161142.g4zslhohb6vvcvwd@localhost>
References: <20170121161142.g4zslhohb6vvcvwd@localhost>
Message-ID: <CAGb2v64sYm6Gt5QL9dr8EqvHwCUcx_St9g+3tMhd76UA4gAJJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 12:11 AM, Rask Ingemann Lambertsen
<rask@formelder.dk> wrote:
> A typo or copy-paste bug means that the register access intended for
> regulator dcdce goes to dcdcb instead. This patch corrects it.
>
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> Fixes: 2ca342d391e3 (regulator: axp20x: Support AXP806 variant)

Acked-by: Chen-Yu Tsai <wens@csie.org>

Can we tag it for 4.9 stable?

Thanks
