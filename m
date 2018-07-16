From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 16 Jul 2018 13:20:13 +0100
Subject: [PATCH v4 01/18] nvmem: add support for cell lookups
In-Reply-To: <20180629094039.7543-2-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-2-brgl@bgdev.pl>
Message-ID: <c460e73f-bfc4-abc6-e61c-26290632a3ab@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/06/18 10:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bgolaszewski@baylibre.com>
> 
> We can currently only register nvmem cells from device tree or by
> manually calling nvmem_add_cells(). The latter options however forces
> users to make sure that the nvmem provider with which the cells are
> associated is registered before the call.
> 
> This patch proposes a new solution inspired by other frameworks that
> offer resource lookups (GPIO, PWM etc.). It adds functions that allow
> machine code to register nvmem lookup which are later lazily used to
> add corresponding nvmem cells and remove them if no longer needed.
> 
> Signed-off-by: Bartosz Golaszewski<bgolaszewski@baylibre.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
