From: monstr@monstr.eu (Michal Simek)
Date: Wed, 19 Nov 2014 11:30:19 +0100
Subject: [GIT PULL] Xilinx Zynq fix for v3.18
In-Reply-To: <20141116230927.GB14929@quad.lixom.net>
References: <5459E081.8000903@monstr.eu>
 <20141109005655.GD13855@quad.lixom.net> <546087F4.3090600@monstr.eu>
 <20141116230927.GB14929@quad.lixom.net>
Message-ID: <546C713B.9080902@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2014 12:09 AM, Olof Johansson wrote:
> On Mon, Nov 10, 2014 at 10:40:04AM +0100, Michal Simek wrote:
>> Hi,
>>
>> On 11/09/2014 01:56 AM, Olof Johansson wrote:
>>> Hi,
>>>
>>> On Wed, Nov 05, 2014 at 09:32:01AM +0100, Michal Simek wrote:
>>>> Hi guys,
>>>>
>>>> please add this fix to your tree.
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>>
>>>> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
>>>>
>>>>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-fixes-for-3.18
>>>>
>>>> for you to fetch changes up to 2de4752d6923d7dcc6e68c23be6a52d5f0896f9d:
>>>>
>>>>   ARM: zynq: Actually remove hotplug.c (2014-10-20 20:53:26 +0200)
>>>
>>> Did you forget to push this tag out? I can't find it in that repo.
>>
>> Unfortunately yes. I forgot to push this tag out.
>> Interesting is that git didn't tell me that.
>>
>> Anyway tag is out there and please consider to pull it.
> 
> 
> Hmm, still not seeing it there.

I found where the problem was. Automation script was deleting it after some time.
Anyway it is pretty late for getting this to 3.18.
I will queue this for v3.19 with others patches.

Will be good if you can take a look at this OCM support.
https://lkml.org/lkml/2014/11/14/183

There are some ways how to do it in connection to slcr (syscon/regmap)
and allocating trampoline size.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/ff2f0bab/attachment.sig>
