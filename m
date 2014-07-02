From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 02 Jul 2014 08:21:09 -0700
Subject: [PATCH v5 04/14] clk: max77686: Improve Maxim 77686 PMIC clocks
 binding
In-Reply-To: <53B3DC52.7040803@collabora.co.uk>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-5-git-send-email-javier.martinez@collabora.co.uk>
 <20140701172959.32686.9863@quantum> <53B3DC52.7040803@collabora.co.uk>
Message-ID: <20140702152109.12768.26689@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Javier Martinez Canillas (2014-07-02 03:17:54)
> Hello Mike,
> 
> On 07/01/2014 07:29 PM, Mike Turquette wrote:
> > Quoting Javier Martinez Canillas (2014-06-26 11:15:36)
> >> Like most clock drivers, the Maxim 77686 PMIC clock binding
> >> follows the convention that the "#clock-cells" property is
> >> used to specify the number of cells in a clock provider.
> >> 
> >> But the binding document is not clear enough that it shall
> >> be set to 1 since the PMIC support multiple clocks outputs.
> >> 
> >> Also, explain that the clocks identifiers are defined in a
> >> header file that can be included by Device Tree source with
> >> client nodes to avoid using magic numbers.
> >> 
> >> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Reviewed-by: Doug Anderson <dianders@chromium.org>
> > 
> > Looks good to me.
> > 
> > Regards,
> > Mike
> > 
> 
> Thanks a lot, an Acked-by or Reviewed-by tags for this patch and 03/14 will be
> great as well so I can carry those on the next version of the series.

Sure you can interpret my "looks good to me" as either an Ack or a
Reviewed-by, depending on context. In this case feel free to add:

Reviewed-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike

> 
> Best regards,
> Javier
> 
