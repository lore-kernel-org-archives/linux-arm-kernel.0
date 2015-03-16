From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 16 Mar 2015 17:53:56 +0000
Subject: [PATCH v2 4/5] PCI: designware: Add disable IO support
In-Reply-To: <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
 <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <550718B4.5090406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/03/15 14:20, Gabriel FERNANDEZ wrote:
>   - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
>     specify this property, to keep backwards compatibility a range of 0x00-0xff
>     is assumed if not present)
> +- disable_io_support: set this property for PCIe host controller without IO
> +  port access
Shouldn't dt properties use hyphens rather than under scores ?
