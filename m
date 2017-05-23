From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 May 2017 15:31:13 +0800
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun8i-a83t
In-Reply-To: <20170522202951.2896280-1-arnd@arndb.de>
References: <20170522202951.2896280-1-arnd@arndb.de>
Message-ID: <CAGb2v64-5d=G23NtZj2Kpx+kT9bxEfFEkfK9nRWh4Ab-8dX0-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 4:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> We get a link error when CCU_MULT is not set with the
> newly added driver:
>
> drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_mult_ops'
> drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.3+0x4): undefined reference to `ccu_mult_ops'
>
> Fixes: 46b492116666 ("clk: sunxi-ng: Add driver for A83T CCU")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

ChenYu
