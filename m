From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 09 Jun 2017 17:35:21 +0900
Subject: [PATCH 3/3] ARM: dts: exynos: Remove the display-timing and
 delay from rinato dts
In-Reply-To: <20170609074509.GD4018@kozik-book>
References: <1496984354-5271-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170609045939epcas1p2e4b50c78978b8f14630ca29550c1cb34@epcas1p2.samsung.com>
 <1496984354-5271-4-git-send-email-hoegeun.kwon@samsung.com>
 <20170609074509.GD4018@kozik-book>
Message-ID: <ffe37769-d2f4-d224-f9b2-6fa0a3af6cff@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2017 04:45 PM, Krzysztof Kozlowski wrote:
> On Fri, Jun 09, 2017 at 01:59:14PM +0900, Hoegeun Kwon wrote:
>> The display-timing and delay are included in the panel driver. So it
>> should be removed in dts.
>>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos3250-rinato.dts | 22 ----------------------
>>   1 file changed, 22 deletions(-)
> I understand this depends on merging in the panel driver so this will
> have to wait till then. I'll take it when panel hits mainline (arm-soc
> folks discourage recently cross-tree merges for DT).
>
> Best regards,
> Krzysztof

Thanks for your reply.
I agree with your opinion,
I will wait for the panel driver to merge.

Best regards,
Hoegeun
