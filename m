From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Nov 2014 10:56:49 +0000
Subject: ARM: sti: SOC_STIH407 and STIH407_RESET?
In-Reply-To: <1415614934.4862.22.camel@x220>
References: <1415614934.4862.22.camel@x220>
Message-ID: <20141110105649.GW21424@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Nov 2014, Paul Bolle wrote:
> Your commit c27321141915 ("ARM: sti: Add STiH407 Kconfig entry to select
> STIH407_RESET") was included in today's linux-next (ie, next-20141110).
> It adds a Kconfig entry for SOC_STIH407. That entry selects
> STIH407_RESET.
> 
> There's no Kconfig symbol STIH407_RESET. And there's nothing in
> next-20141110 that cares about SOC_STIH407. So this entry is currently a
> nop.

You're right, thanks for your diligence.

> I assume that there are one or more patches queued that make this entry
> do something. Is that correct?

That is also true.  Patch is en route.

It should be coming through the reset tree and arm-soc.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
