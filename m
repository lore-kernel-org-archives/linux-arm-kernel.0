From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2012 13:16:05 +0100
Subject: [PATCH 6/8] serial: xilinx_uartps: kill CONFIG_OF conditional
In-Reply-To: <61e872b2cd4abc25c2dab82668e5094b590571a0.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <61e872b2cd4abc25c2dab82668e5094b590571a0.1351721190.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3dKSn0JwHsgCfLrgitb41OakHmw1o=uDRkshYi88fp2h1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/30 Josh Cartwright <josh.cartwright@ni.com>:
> The Zynq platform requires the use of CONFIG_OF.  Remove the #ifdef
> conditionals in the uartps driver.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 9 ---------
>  1 file changed, 9 deletions(-)

Please send this separately out of this patchset.
Also if you do this change which is understandable, you should also
add
depends on OF

Thanks,
Michal
