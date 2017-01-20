From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 20 Jan 2017 19:16:28 +0530
Subject: [PATCH RESEND 2/2] ARM: da850: add the nand dev_id to the clock
 lookup table
In-Reply-To: <1484301626-30345-3-git-send-email-bgolaszewski@baylibre.com>
References: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
 <1484301626-30345-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <0650f8ff-07f7-db06-ca3c-84eed7edb24e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 January 2017 03:30 PM, Bartosz Golaszewski wrote:
> The aemif driver can now access struct of_dev_auxdata (using platform
> data).
> 
> Add the device id to the clock lookup table for the nand clock and
> create a separate lookup table for aemif subnodes.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to v4.11/soc

Thanks,
Sekhar
