From: david@lechnology.com (David Lechner)
Date: Mon, 25 Jun 2018 11:23:25 -0500
Subject: [PATCH 9/9] ARM: davinci: kill davinci_aemif_setup()
In-Reply-To: <20180625152920.11549-10-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-10-brgl@bgdev.pl>
Message-ID: <e6dc21f3-aa09-54e0-3090-b4913075b09e@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> All users now register platform devices using the ti-aemif driver.
> Remove the handcrafted aemif API.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

I found the subject line to be a bit misleading since this patch
removes an entire file, not just the one function mentioned.
