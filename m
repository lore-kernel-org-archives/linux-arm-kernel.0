From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 8 Jul 2013 22:42:46 +0530
Subject: [PATCH V2] ARM: tegra: enable gpio-keys on dalmore
In-Reply-To: <51DADFEC.1050901@wwwdotorg.org>
References: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
 <51DADFEC.1050901@wwwdotorg.org>
Message-ID: <51DAF30E.9000101@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 July 2013 09:21 PM, Stephen Warren wrote:
> On 07/06/2013 03:14 AM, Laxman Dewangan wrote:
>
>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
>> @@ -976,4 +1005,5 @@
>>   			 <&tegra_car TEGRA114_CLK_EXTERN1>;
>>   		clock-names = "pll_a", "pll_a_out0", "mclk";
>>   	};
>> +
>>   };
> What's that? I'll try to remember to fix this up when applying, but
> proof-reading would help.

Oops.. My bad.. Did not see the bottom when doing patch review.

Let me know if I need to send V4 if it is easy for you to handle?
