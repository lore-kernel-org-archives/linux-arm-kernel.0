From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 16 May 2015 12:27:27 +0900
Subject: [PATCH v2] ARM: dts: Add syscon property to the MIPI phy in
 exynos5420
In-Reply-To: <CAJKOXPd7=wnjCd6Xz9ZNuvbxWi=cSr+eRj9YdPWA0PHR+AOTeA@mail.gmail.com>
References: <1431607240-14549-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAJKOXPd7=wnjCd6Xz9ZNuvbxWi=cSr+eRj9YdPWA0PHR+AOTeA@mail.gmail.com>
Message-ID: <5556B91F.20103@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/15 22:22, Krzysztof Kozlowski wrote:
> 2015-05-14 21:40 GMT+09:00 Tomeu Vizoso <tomeu.vizoso@collabora.com>:
>> Since e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression by
>> adding support for PMU regmap") the syscon property is required in
>> samsung,s5pv210-mipi-video-phy nodes, but this DTS hadn't been updated
>> yet.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Krzysztof Koz?owski <k.kozlowski@samsung.com>
>>
>> --
> 
> Triple-dash please, because this won't be cut by "git am".
> 
> Everything else looks fine, thank you.
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
Applied, thanks for you guys' effort.

- Kukjin
