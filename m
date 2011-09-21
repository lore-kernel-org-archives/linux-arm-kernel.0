From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Sep 2011 00:50:18 -0300
Subject: [PATCH] mxcuart: add polled io methods
In-Reply-To: <1316396718-31886-2-git-send-email-compnerd@compnerd.org>
References: <1316396718-31886-1-git-send-email-compnerd@compnerd.org>
	<1316396718-31886-2-git-send-email-compnerd@compnerd.org>
Message-ID: <CAOMZO5CdVqCu8VvaYmxhDW-anG2NQt8Hn3CnM_a48g9V0q9bmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saleem,

On Sun, Sep 18, 2011 at 10:45 PM, Saleem Abdulrasool
<compnerd@compnerd.org> wrote:
> ---
> ?drivers/serial/mxc_uart.c | ? 78 +++++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 78 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/mxc_uart.c b/drivers/serial/mxc_uart.c
> index 347a746..5769465 100644
> --- a/drivers/serial/mxc_uart.c
> +++ b/drivers/serial/mxc_uart.c

You missed a commit message and your Signed-off-by line.

Have you tried using KGDB after applying your patch?

Regards,

Fabio Estevam
