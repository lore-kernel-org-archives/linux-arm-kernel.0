From: david@lechnology.com (David Lechner)
Date: Mon, 22 Jan 2018 10:50:03 -0600
Subject: [PATCH] ARM: dts: da850-lego-ev3: use a correct fallback for at24
 compatible
In-Reply-To: <20180122125505.16806-1-brgl@bgdev.pl>
References: <20180122125505.16806-1-brgl@bgdev.pl>
Message-ID: <c4c07714-4937-48bd-466d-c2c9848c4725@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2018 06:55 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now require all at24 users to use the "atmel,<model>" fallback in
> device tree for different manufacturers.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
