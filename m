From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Jul 2018 18:35:02 +0200
Subject: [PATCH 3/5] net: fortify eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-4-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-4-brgl@bgdev.pl>
Message-ID: <20180718163502.GC12477@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 06:10:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We'll soon have more sources from which to read the MAC address in this
> routine. Make sure the address is correct before returning it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
