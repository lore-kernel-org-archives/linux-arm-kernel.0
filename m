From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 12 Feb 2015 19:12:37 -0200
Subject: [PATCH] Revert "clk: mxs: Fix invalid 32-bit access to frac
 registers"
In-Reply-To: <1423773007-10752-1-git-send-email-stefan.wahren@i2se.com>
References: <1423773007-10752-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5Akvc3-h_=wj5P2aM__w8dX4kdLCuELwg9T0t=S5--zrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 6:30 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Revert commit 039e59707507 (clk: mxs: Fix invalid 32-bit access to frac
> registers), because it leads to a faulty spi communication on mx28evk.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, Stefan

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
