From: mathias.nyman@intel.com (Mathias Nyman)
Date: Wed, 13 Apr 2016 20:00:39 +0300
Subject: [PATCH] usb: host: xhci-plat: Make enum xhci_plat_type start
 at a non zero value
In-Reply-To: <20160411154436.GA14580@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1458917188-28452-1-git-send-email-peter.griffin@linaro.org>
 <20160411154436.GA14580@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <570E7B37.1030706@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.04.2016 18:44, Peter Griffin wrote:
> Hi Mathias,
>
> On Fri, 25 Mar 2016, Peter Griffin wrote:
>
>> Otherwise generic-xhci and xhci-platform which have no data get wrongly
>> detected as XHCI_PLAT_TYPE_MARVELL_ARMADA by xhci_plat_type_is().
>>
>> This fixes a regression in v4.5 for STiH407 family SoC's which use the
>> synopsis dwc3 IP, whereby the disable_clk error path gets taken due to
>> wrongly being detected as XHCI_PLAT_TYPE_MARVELL_ARMADA and the hcd never
>> gets added.
>>
>> I suspect this will also fix other dwc3 DT platforms such as Exynos,
>> although I've only tested on STih410 SoC.
>>
>> Fixes: 4efb2f694114 ("usb: host: xhci-plat: add struct xhci_plat_priv")
>
> Can you take this 1 charcter fix for the next -rc?
>

added to my tree and sent forward to Greg

-Mathias
