From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 07 Feb 2013 11:56:15 +0530
Subject: [PATCH 1/5] ARM: dts: exynos5250-arndale: Add node entry for
 gpio-buttons
In-Reply-To: <F3DBB1B3EF102E4994C89758CFCA32412C4E1A@DBDE01.ent.ti.com>
References: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
 <F3DBB1B3EF102E4994C89758CFCA32412C4E1A@DBDE01.ent.ti.com>
Message-ID: <51134907.1050803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 11:47 AM, Kumar, Anil wrote:
> On Thu, Feb 07, 2013 at 10:45:25, Tushar Behera wrote:
>> Added GPIO buttons DT node to Arndale board file.
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> This series is based on for-next branch of Kukjin Kim's tree
>> and added on top of the below patch:
>> https://patchwork.kernel.org/patch/2042451/
>> ---
>>  arch/arm/boot/dts/exynos5250-arndale.dts |   48 ++++++++++++++++++++++++++++++
>>  1 files changed, 48 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
>> index 63572f9..9ce40df 100644
>> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
>> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
>> @@ -119,4 +119,52 @@
>>  	spi_2: spi at 12d40000 {
>>  		status = "disabled";
>>  	};
>> +
>> +	gpio_keys {
>> +		compatible = "gpio-keys";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> 
> Just want to understand why these properties are here?  
> As these properties are for child dt node. But have not seen
> anyone is using here.
> 

That is how gpio_keys node entries are defined in other .dts files.

-- 
Tushar Behera
