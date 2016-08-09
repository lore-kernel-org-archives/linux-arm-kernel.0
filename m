From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 9 Aug 2016 15:59:28 +0200
Subject: [PATCH V2] usb: ehci-platform: use helper variables in probe
 function
In-Reply-To: <1468559156-17270-1-git-send-email-zajec5@gmail.com>
References: <1468398548-5050-1-git-send-email-zajec5@gmail.com>
 <1468559156-17270-1-git-send-email-zajec5@gmail.com>
Message-ID: <20160809135928.GB3021@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 07:05:56AM +0200, Rafa? Mi?ecki wrote:
> Probing function was using &dev->dev and dev->dev.of_node over 20 times
> so I believe it made sense to use helper variables for both of them.
> To avoid some uncommon variable name for struct device I first replaced
> existing dev variable with pdev.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> V2: Use 2 extra tabs after line break to match one of already used
>     coding styles.

Same comment here, unnecessary churn, sorry.

greg k-h
