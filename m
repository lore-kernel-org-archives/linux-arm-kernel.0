From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Apr 2014 07:04:44 +0200
Subject: [GIT PULL] serial: Cadence
In-Reply-To: <20140424232332.GB10457@kroah.com>
References: <53575983.3030508@monstr.eu> <20140423234832.GB17827@kroah.com>
 <5358A188.4080404@monstr.eu> <20140424232332.GB10457@kroah.com>
Message-ID: <5359ECEC.5050902@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 01:23 AM, Greg Kroah-Hartman wrote:
> On Thu, Apr 24, 2014 at 07:30:48AM +0200, Michal Simek wrote:
>> On 04/24/2014 01:48 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Apr 23, 2014 at 08:11:15AM +0200, Michal Simek wrote:
>>>> Hi Greg,
>>>>
>>>> this is around for a while and I would like to close it.
>>>> I have applied patches 1-7 from v3.
>>>> Patches 8 and 9 should go through arm-soc tree and I will add them
>>>> to my zynq/dt branch.
>>>>
>>>> Please apply these patches to your tree.
>>>> If this should go through different tree please let me know.
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>>
>>>> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
>>>>
>>>>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.monstr.eu/linux-2.6-microblaze.git tags/cadence-uart-for-3.16
>>>
>>> I can't take git pulles from random internet sites, sorry.  Just send
>>> these as email and I will queue them up.
>>
>> I wouldn't say random. This repo is listed in my Microblaze maintainer fragment
>> and I used signed tag and you have sign my key that's why you can easily
>> check it.
> 
> If you have a signed key, why aren't you using git.kernel.org?  Again, I
> can't pull from any non-kernel.org sites, sorry.

ok. I have never had a need to have git repo at kernel.org.
But maybe I should asked for one.


>> Anyway we have sent v3 patches via email twice.
>> Origin v3:
>> https://lkml.org/lkml/2014/3/12/499
>>
>> Resent v3:
>> https://lkml.org/lkml/2014/4/4/523
>>
>> Patches 1-7 should go through your tree.
> 
> I've now applied these, sorry for the delay.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/6997c21d/attachment.sig>
