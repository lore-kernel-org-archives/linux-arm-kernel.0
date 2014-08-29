From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 29 Aug 2014 06:57:15 +0200
Subject: [PATCH] ARM: zynq: DT: Add LEDs to zc702 DT
In-Reply-To: <20140828171536.GB4345@xsjandreislx>
References: <1409242973-2735-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140828171536.GB4345@xsjandreislx>
Message-ID: <93dd8f20-f13a-4446-8b11-e8508fc0ebb7@BY2FFO11FD047.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2014 07:15 PM, S?ren Brinkmann wrote:
> On Thu, 2014-08-28 at 09:22AM -0700, Soren Brinkmann wrote:
>> From: Ezra Savard <ezra.savard@xilinx.com>
>>
>> Adds LEDs to the zc702 devicetree for use with the leds-gpio driver.
>>
>> Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
>> Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>  arch/arm/boot/dts/zynq-zc702.dts | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
>> index 835c3089c61c..4e9fe26b3e85 100644
>> --- a/arch/arm/boot/dts/zynq-zc702.dts
>> +++ b/arch/arm/boot/dts/zynq-zc702.dts
>> @@ -27,6 +27,16 @@
>>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>>  	};
>>  
>> +	gpio-leds {
> The node name should rather be just 'leds'. That slipped through, sorry.
> Do you want a v2 for that?

yes, please send v2.

Thanks,
Michal



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/66e2de46/attachment.sig>
