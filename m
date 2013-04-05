From: monstr@monstr.eu (Michal Simek)
Date: Fri, 05 Apr 2013 16:14:45 +0200
Subject: linux-next: manual merge of the arm-soc tree with the xilinx tree
In-Reply-To: <201304051532.46156.arnd@arndb.de>
References: <20130405153335.baf29606a97b1bee415f3546@canb.auug.org.au>
 <201304051409.37708.arnd@arndb.de>
 <CAHTX3d+PZ=G6JYBo7Hvqe=G77udaCFJ4pD4z_sQw_FDGP-xt=A@mail.gmail.com>
 <201304051532.46156.arnd@arndb.de>
Message-ID: <515EDC55.7090609@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 03:32 PM, Arnd Bergmann wrote:
> On Friday 05 April 2013, Michal Simek wrote:
>>>> Interesting. I rebased my arm-next branch based on 3.9-rc5
>>>> with some Rob's + one Arnd patch from arm-soc - clksrc/cleanup branch.
>>>>
>>>> I will fix my arm-next branch.
>>>
>>> The for-next branch in arm-soc is not stable, you should never base
>>> anything on it. If you depend on some stable branch, that is in arm-soc,
>>> then use just that branch, not one of the next/* branches or for-next.
>>>
>>
>> I haven't based on arm-soc for-next branch my arm-next branch.
>> I just took all patches I need for zynq and done git rebase v3.5-rc5.
>> Which caused that I have became commuter of that 4 patches
>> and there is probably any conflict between your for-next branch and
>> clksrc/cleanup
>> which you have resolved in for-next branch.
>
> Ah, I see. That was actually my fault, I'm sorry for causing trouble
> here and then accusing you instead.
>
>> And because of my rebase sha1 are different that's why Stephen
>> had problem with it.
>> I have changed my arm-next branch and will see on Monday if Stephen
>> will report any problem or not.
>
> Ok, thanks!

No worries.

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
