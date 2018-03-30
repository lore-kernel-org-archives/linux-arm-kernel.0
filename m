From: david@lechnology.com (David Lechner)
Date: Fri, 30 Mar 2018 12:13:28 -0500
Subject: [PATCH v5 4/8] remoteproc/davinci: add the missing retval check
 for clk_enable()
In-Reply-To: <20180330152856.12297-5-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
 <20180330152856.12297-5-brgl@bgdev.pl>
Message-ID: <6d4dcee6-6480-03fb-c0f8-f750d22f8cf6@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/30/18 10:28 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci platform is being switched to using the common clock
> framework, where clk_enable() can fail. Add the return value check.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Suman Anna <s-anna@ti.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
