From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 14 Mar 2017 05:43:18 +0800
Subject: [PATCH] [for 4.11]xhci: plat: Register shutdown for xhci_plat
In-Reply-To: <1489440074-23966-1-git-send-email-awallis@codeaurora.org>
References: <1489440074-23966-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20170313214318.GA5539@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 05:21:14PM -0400, Adam Wallis wrote:
> Shutdown should be called for xhci_plat devices especially for
> situations where kexec might be used by stopping DMA
> transactions.
> 
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>  drivers/usb/host/xhci-plat.c | 1 +
>  1 file changed, 1 insertion(+)

$ ./scripts/get_maintainer.pl --file drivers/usb/host/xhci-plat.c
Mathias Nyman <mathias.nyman@intel.com> (supporter:USB XHCI DRIVER)

:(
