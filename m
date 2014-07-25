From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 09:38:31 +0200
Subject: [PATCH v2 04/11] ARM: dts: zynq: Update deprecated xuartps clock
 names
In-Reply-To: <50aad941-92d9-428a-a708-77040e24b651@BY2FFO11FD008.protection.gbl>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-5-git-send-email-afaerber@suse.de>
 <82ab6426-211e-451e-99c3-df40dbea817e@BN1AFFO11FD039.protection.gbl>
 <53D1931C.7080409@suse.de>
 <50aad941-92d9-428a-a708-77040e24b651@BY2FFO11FD008.protection.gbl>
Message-ID: <53D20977.2050605@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 01:24 AM, S?ren Brinkmann wrote:
> On Fri, 2014-07-25 at 01:13AM +0200, Andreas F?rber wrote:
>> Am 25.07.2014 01:09, schrieb S?ren Brinkmann:
>>> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>>>> Avoids deprecation warning messages.
>>>
>>> A patch that updates those names is already in armsoc.
>>
>> Which tree/branch should I base this series on then? It seemed the
>> Xilinx branches were all heavily outdated some days ago, so this is
>> against vanilla v3.16-rc6.

I have updated that branches. From my experience none is looking
at these branches and I mainly use them for communication
with arm-soc where sign tags are used which you can see them there.

> 
> That is something for the maintainers to answer. But in general, you're
> adding a lot of stuff that is not yet upstream, AFAIK. Some is still
> under review I think (like QSPI), others are just staged for the next
> merge window and parts are still in flight. Michal hopefully has a
> better overview.
> This particular patch can simply be omitted I think.

There are several options and I think the best is arm-soc tree
where you can see what have been accepted.
And also I believe all arm-soc trees are added to linux-next.

That's why I would use linux-next or arm-soc.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/3939a92d/attachment-0001.sig>
