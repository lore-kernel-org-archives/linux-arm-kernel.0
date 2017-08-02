From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 2 Aug 2017 06:44:56 -0700
Subject: [patch v1 1/2] drivers: jtag: Add JTAG core driver
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170802134456.GD27481@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 04:18:37PM +0300, Oleksandr Shamray wrote:
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	default n

'n' is always the default, no need for this line at all.

thanks,

greg k-h
