From: monstr@monstr.eu (Michal Simek)
Date: Tue, 28 Jul 2015 07:42:11 +0200
Subject: [RFCv2 2/3] dts: zynq: Add devicetree entry for Xilinx Zynq reset
 controller.
In-Reply-To: <CAAtXAHepDRbiiznHnT3dLLLWS_VH2a9BhnNgZzDECx__QceEeg@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-3-git-send-email-moritz.fischer@ettus.com>
 <55B5D62D.4010407@monstr.eu>
 <CAAtXAHepDRbiiznHnT3dLLLWS_VH2a9BhnNgZzDECx__QceEeg@mail.gmail.com>
Message-ID: <55B71633.8060608@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 07:03 AM, Moritz Fischer wrote:
> Hi Michal,
> 
> I agree we need to be careful with changing the bindings.
> 
> On Sun, Jul 26, 2015 at 11:56 PM, Michal Simek <monstr@monstr.eu> wrote:
>> Hi Moritz,
>>
>> On 07/25/2015 02:21 AM, Moritz Fischer wrote:
>>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>>> ---
>>>  arch/arm/boot/dts/zynq-7000.dtsi            | 43 ++++++++++++-
>>
>> This patch is nice in general but every change in binding should be
>> discussed separately. There is also necessary to wire them up in the
>> driver to do action. That's why I think that will be the best just to
>> add the code to slcr and keep others untouched.
> 
> Ok, just to clarify: You'd suggest to just add the rstc as child node
> to the slcr,
> and leave the other nodes untouched?

yes and then add it on case-by-case basis.

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/33cd6c21/attachment.sig>
