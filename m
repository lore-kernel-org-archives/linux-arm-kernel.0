From: david@lechnology.com (David Lechner)
Date: Fri, 29 Jun 2018 12:09:21 -0500
Subject: [PATCH v4 09/18] ARM: davinci: da850-evm: remove dead MTD code
In-Reply-To: <20180629094039.7543-10-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-10-brgl@bgdev.pl>
Message-ID: <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We no longer need to register the MTD notifier to read the MAC address
> as it's now being done in the emac address.

I think you mean "it's now being done in the emac _driver_"
