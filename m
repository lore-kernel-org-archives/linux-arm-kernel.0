From: monstr@monstr.eu (Michal Simek)
Date: Fri, 20 Dec 2013 13:29:12 +0100
Subject: [GIT PULL] Xilinx Zynq clk changes for v3.14
In-Reply-To: <20131219192657.18119.4291@quantum>
References: <52B16A4B.1000706@monstr.eu> <20131219051219.18119.26127@quantum>
 <52B2A22D.6080304@monstr.eu> <20131219192657.18119.4291@quantum>
Message-ID: <52B43818.4020305@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 08:26 PM, Mike Turquette wrote:
> Quoting Michal Simek (2013-12-18 23:37:17)
>> Hi Mike,
>>
>> On 12/19/2013 06:12 AM, Mike Turquette wrote:
>>> Quoting Michal Simek (2013-12-18 01:26:35)
>>>> Hi Mike,
>>>>
>>>> As we discussed it is better for you to get pull request with signed tags.
>>>> That's why I am sending you pull request for 2 patches which we have in queue which
>>>> should go to v3.14.
>>>
>>> Michal,
>>>
>>> Thanks much for the pull request. In the future it is a bit easier if
>>> you base your pull request on the tip of clk-next, but it's not a big
>>> deal.
>>
>> ok. No problem to do.
>>
>>>
>>> Shouldn't the change to zynq-7000.dtsi go through the arm-soc tree
>>> instead of the clk tree?
>>
>> It is here because it is related to clock and there is no conflict
>> with others DT changes we made for 3.14.
>> But if you prefer not to have this change here I have no problem
>> to add it to our zynq/clk branch and go through arm-soc tree.
> 
> I think it is better to take the dts patch through arm-soc. Merge
> conflicts seem unlikely now, but it's best to err on the side of caution
> and send that patch through the correct tree.

ok. No problem with that.

Will send you new pull request based on clk-next branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/d1a554bf/attachment-0001.sig>
