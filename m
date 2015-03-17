From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 18 Mar 2015 02:19:45 +0900
Subject: [PATCH v2] ARM: EXYNOS: Use platform device name as power domain
 name
In-Reply-To: <7h61a7xxoo.fsf@deeprootsystems.com>
References: <1426067672-21589-1-git-send-email-k.kozlowski@samsung.com>
 <7h61a7xxoo.fsf@deeprootsystems.com>
Message-ID: <55086231.7090408@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/15 02:15, Kevin Hilman wrote:
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
>> The power domain nodes in DTS may be very generic (e.g. "power-domain"
>> for Exynos 5420) making it very hard to debug:
>>
>> $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>>     domain                      status         slaves
>> power-domain                    on
>>
>> Use platform device name instead so the names will be a little more user
>> friendly:
>>     domain                      status         slaves
>> 100440e0.power-domain           on
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> I still think we need some more detail as wel, but this is a good step
> in the right direction.
> 
Thanks, applied.

- Kukjin
