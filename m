From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Sep 2015 16:08:58 +0900
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <560B8A0F.8090709@osg.samsung.com>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
 <560B2D29.5060707@samsung.com> <560B8818.8020002@kernel.org>
 <560B890C.3060200@samsung.com> <560B8A0F.8090709@osg.samsung.com>
Message-ID: <560B8A8A.5050506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2015 16:06, Javier Martinez Canillas wrote:
> Hello,
> 
> On 09/30/2015 09:02 AM, Krzysztof Kozlowski wrote:
>> On 30.09.2015 15:58, Kukjin Kim wrote:
> 
> [snip]
> 
>>>>
>>>> Could you add the new compatible and fix patch issues pointed by Doug?
>>>>
>>> Documenting for the compatibles would be required even I already applied
>>> its updated patch...
>>
> 
> Kukjin, I agree that they should be documented but I thought it would
> be a separate patch since currently we don't document any board.
>  
>> What do you mean by "documenting compatibles"? These are board
>> compatibles, they are not documented...
>>
> 
> Krzysztof, I've on my TODO list to add a file describing all Exynos
> platforms and DT bindings, something like what other SoC do, i.e:
> 
> Documentation/devicetree/bindings/arm/omap/omap.txt
> Documentation/devicetree/bindings/arm/rockchip.txt

Right, that's a good idea. However lack of it does not affect current
work because compatibles for Exynos board are not documented at all.

Best regards,
Krzysztof
