From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Nov 2013 06:28:05 +0100
Subject: [PATCH v2 1/2] mmc: arasan: Add driver for Arasan SDHCI
In-Reply-To: <9e92f3b2-5434-4fcf-b7f5-3f634175193c@CO1EHSMHS024.ehs.local>
References: <1383151090-13885-1-git-send-email-soren.brinkmann@xilinx.com>
 <87mwkqeojd.fsf@octavius.laptop.org>
 <9e92f3b2-5434-4fcf-b7f5-3f634175193c@CO1EHSMHS024.ehs.local>
Message-ID: <529582E5.4010809@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 11/27/2013 12:39 AM, S?ren Brinkmann wrote:
> Hi Chris,
> 
> On Tue, Nov 26, 2013 at 06:22:46PM -0500, Chris Ball wrote:
>> Hi Soren, sorry for the late review, just trivial changes:
> No problem. Thanks for looking at it.
> 
>>
>> On Wed, Oct 30 2013, Soren Brinkmann wrote:
>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> new file mode 100644
>>> index 000000000000..ef4c5ac753e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>> @@ -0,0 +1,27 @@
>>> +Device Tree Bindings for the Arasan SDCHI Controller
>>
>> SDHCI
> Oops. Will be fixed.
> 
>>
>>> +
>>> +  The bindings follow the mmc[1], clock[2] and interrupt[3] bindings. Only
>>> +  deviations are documented here.
>>> +
>>> +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
>>> +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +  [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> +
>>> +Required Properties:
>>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>>> +  - reg: From mmc bindings: Register location and length.
>>
>> Actually, reg/interrupts are from the OF core.  There's no need to
>> mention them here.
> Tomasz complained when I left those parts out so I added them in v2.
> Since it's there now, I don't mind either way. Let's just agree on one
> way or the other.
> 

Binding was Acked-by Rob and that's why I believe this should be fine.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/1bc82d6f/attachment.sig>
