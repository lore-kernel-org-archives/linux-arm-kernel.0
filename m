From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 26 Oct 2018 15:52:07 -0500
Subject: [PATCH] ARM: dts: socfpga: Fix SDRAM node address for Arria10
In-Reply-To: <0e965db7-78e7-afba-2b6e-0ccd1b73ae36@linux.intel.com>
References: <1537888870-357-1-git-send-email-thor.thayer@linux.intel.com>
 <0e965db7-78e7-afba-2b6e-0ccd1b73ae36@linux.intel.com>
Message-ID: <426902dc-4a25-9707-da45-8612ccbd674c@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/26/2018 03:14 PM, Thor Thayer wrote:
> Gentle ping.
> 
> On 9/25/18 10:21 AM, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> The address in the SDRAM node was incorrect. Fix this to agree with the
>> correct address and to match the reg definition block.
>>
>> Cc: stable at vger.kernel.org
>> Fixes: 54b4a8f57848b("arm: socfpga: dts: Add Arria10 SDRAM EDAC DTS
>> support")
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> ? arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
>> ? 1 file changed, 1 insertion(+), 1 deletion(-)

This is already in arm-soc/next/dt and should land in v4.20-rc1.

Dinh
