From: monstr@monstr.eu (Michal Simek)
Date: Mon, 10 Aug 2015 13:13:26 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v4.3
In-Reply-To: <20150808005509.2416.8174@quantum>
References: <55BB31E8.7040806@monstr.eu> <20150805085344.GH6390@localhost>
 <20150808005509.2416.8174@quantum>
Message-ID: <55C88756.1090309@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/08/2015 02:55 AM, Michael Turquette wrote:
> Quoting Olof Johansson (2015-08-05 01:53:44)
>> Hi,
>>
>> On Fri, Jul 31, 2015 at 10:29:28AM +0200, Michal Simek wrote:
>>> Hi,
>>>
>>> please pull these SoC changes to your tree.
>>>
>>> Thanks,
>>> Michal
>>>
>>> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>>>
>>>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.3
>>>
>>> for you to fetch changes up to e4a9288942392965bd5cfad93d9996b83c0dc4a6:
>>>
>>>   ARM: zynq: reserve space for jump target in secondary trampoline
>>> (2015-07-31 10:24:41 +0200)
>>
>> Merged, however:
>>
>>> Arun Chandran (1):
>>>       ARM: zynq: Fix earlyprintk in big endian mode
>>>
>>> Masahiro Yamada (1):
>>>       clk: zynq: remove redundant $(CONFIG_ARCH_ZYNQ) in Makefile
>>
>> This should have gone through the clk tree. Seems small and simple enough that
>> I'll take it, but please send patches through appropriate maintainers.
>>
>> (Adding Mike and Stephen on cc so they know about it).
> 
> Olof,
> 
> Thanks for the heads up.
> 
> Michal,
> 
> No reason that patch couldn't have gone through the clk tree. It was
> posted on July 27th, which wasn't that long ago. Please feel free to
> ping Stephen or I on #linux-clk if you think one of your clk patches has
> slipped through the cracks.

I took it because it was pretty simple and there was no reaction from
you. Thanks for sending link to IRC. I wasn't aware that there is any
clk specific IRC.
Next time I will make sure that patches will go in the right direction.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150810/b36e9016/attachment.sig>
