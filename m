From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 12 Jan 2015 17:37:59 +0900
Subject: [PATCH v3] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <7htwzzvq0v.fsf@deeprootsystems.com>
References: <1420671228-24692-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <7htwzzvq0v.fsf@deeprootsystems.com>
Message-ID: <54B387E7.3080406@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/15 02:10, Kevin Hilman wrote:
> Sjoerd Simons <sjoerd.simons@collabora.co.uk> writes:
> 
>> Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
>> same as the vendors naming, which means it's prefixed with exynos5422
>> instead of exynos5800 as the SoC name even though it includes the
>> exyno5800 dtsi.
>>
>> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> Boot tested on top of next-20150109 (with and without my hack for
> bringing up 8 cores.)
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
Thanks for your test, Kevin.

I've applied, need to update devicetree bindings for samsung-boards
though because it can be updated later.

Thanks,
Kukjin
