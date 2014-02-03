From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Feb 2014 09:27:05 +0000
Subject: [PATCH 04/18] mfd: max14577: Add of_compatible to extcon mfd_cell
In-Reply-To: <1390911522-28209-5-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203092705.GF13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014, Krzysztof Kozlowski wrote:

> Add of_compatible ("maxim,max14577-muic") to the mfd_cell for extcon
> driver. If entry with such compatible is present in the DTS, the extcon
> driver will have of_node set.
> 
> This may be useful for extcon consumers and it is documented in
> bindings documentation.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/max14577.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
