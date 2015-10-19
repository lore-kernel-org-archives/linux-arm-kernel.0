From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 08:53:23 +0900
Subject: [PATCH 0/5] ARM: dts: fix cpu compatible values
In-Reply-To: <5625303C.6090902@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
 <5625303C.6090902@mleia.com>
Message-ID: <56258273.1080909@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 03:02, Vladimir Zapolskiy wrote:
> On 25.09.2015 20:35, Vladimir Zapolskiy wrote:
>> The changeset corrects severeal cpu compatible properties
>> to defined ones in Documentation/devicetree/bindings/arm/cpus.txt
>>
>> Vladimir Zapolskiy (5):
>>   ARM: dts: i.MX31: fix cpu compatible value
>>   ARM: dts: i.MX35: fix cpu compatible value
> 
> Ping. Two patches above are applied by Shawn, could ARM maintainers
> apply the rest? Thank you in advance.
> 
>>   ARM: dts: S3C2416: fix cpu compatible value

S3C2416 is already applied:
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/commit/?h=for-next&id=6716f6c6b8ae69e2abbea5e9c0c3c274be57d927

Best regards,
Krzysztof

>>   ARM: dts: TI-Nspire: fix cpu compatible value
>>   ARM: dts: WM8750: fix cpu compatible value
>>
>>  arch/arm/boot/dts/imx31.dtsi   | 2 +-
>>  arch/arm/boot/dts/imx35.dtsi   | 2 +-
>>  arch/arm/boot/dts/nspire.dtsi  | 2 +-
>>  arch/arm/boot/dts/s3c2416.dtsi | 2 +-
>>  arch/arm/boot/dts/wm8750.dtsi  | 2 +-
>>  5 files changed, 5 insertions(+), 5 deletions(-)
>>
> 
> --
> With best wishes,
> Vladimir
> 
