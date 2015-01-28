From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Jan 2015 18:55:25 -0200
Subject: [PATCH V2] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
References: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5CQVHD2bJbh4whmd7yxq0Mia7Gr+53W7z5pE+GrAkszgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sun, Dec 28, 2014 at 8:26 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> According to i.MX23 and i.MX28 reference manual the fractional
> clock control registers must be addressed by byte instructions.
>
> This patch fixes the erroneous 32-bit access to these registers
> and extends the comment in the init functions.
>
> Btw the imx23 init now uses a R-M-W sequence just like imx28 init
> to avoid any clock glitches.
>
> The changes has been tested only with a i.MX28 board, because i don't
> have access to an i.MX23 board.

As you recently had a chance to test it on mx23, maybe you could
resend it and change this last parapgraph.

Regards,

Fabio Estevam
