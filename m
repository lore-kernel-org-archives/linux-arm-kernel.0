From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Aug 2016 08:19:50 +0200
Subject: [PATCH 1/5] arm/defconfigs: Remove CONFIG_IPV6_PRIVACY
In-Reply-To: <20160812052217.GA12013@nazgul.tnic>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
 <4958578.R1lMSWqhcA@wuerfel> <20160811213521.GD10636@nazgul.tnic>
 <1769762.X0BZWCkYAE@wuerfel> <20160812052217.GA12013@nazgul.tnic>
Message-ID: <c74d254d-6fcc-670d-f1a8-902480cab6d0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2016 07:22 AM, Borislav Petkov wrote:
> On Thu, Aug 11, 2016 at 11:51:38PM +0200, Arnd Bergmann wrote:
>> That patch looks good, sorry I missed it. I see that Vladimir already
>> did the lpc32xx portion of it, can you send the part for s3c24xx
>> to the exynos maintainers?
> 
> I see you've added them to CC, thanks Arnd. Here it is:
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Fri, 12 Aug 2016 07:18:20 +0200
> Subject: [PATCH] arm/s3c2410_defconfig: Remove CONFIG_IPV6_PRIVACY
> 
> Option is long gone, see
> 
>   5d9efa7ee99e ("ipv6: Remove privacy config option.")
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/s3c2410_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied.

Best Regards,
Krzysztof
