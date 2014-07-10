From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 10 Jul 2014 16:03:53 -0700
Subject: [PATCH] tty: serial: fsl_lpuart: add 32-bit register interface
 support
In-Reply-To: <1404204226-24452-1-git-send-email-jingchang.lu@freescale.com>
References: <1404204226-24452-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140710230353.GA25661@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:43:46PM +0800, Jingchang Lu wrote:
> This add the big-endian 32-bit register version LPUART support.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 652 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 643 insertions(+), 9 deletions(-)

This patch fails to apply to my tree :(

Can you refresh it against the tty-next branch of the tty.git tree on
git.kernel.org and resend?

thanks,

greg k-h
