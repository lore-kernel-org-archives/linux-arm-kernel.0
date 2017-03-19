From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 19 Mar 2017 20:12:48 +0000
Subject: [PATCH] ARM: wire up statx syscall
References: <20170317094204.15630-1-chris.packham@alliedtelesis.co.nz>
 <20170317095945.GY21222@n2100.armlinux.org.uk>
Message-ID: <a1a1f1cccadb48d599ac9ac013ee7fab@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 23:00, Russell King - ARM Linux wrote:
> You obviously have not looked in linux-next.

No I haven't. But even now I see nothing in 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

I did do a search of the ARM mailing list.

site:http://lists.infradead.org/pipermail/linux-arm-kernel/ statx

shows neither my patch nor any other patch. Is there a better index I 
should be looking at?

> Not applying _your_ patch.
>
> On Fri, Mar 17, 2017 at 10:42:04PM +1300, Chris Packham wrote:
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>  arch/arm/tools/syscall.tbl | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
>> index 3c2cb5d5adfa..0bb0e9c6376c 100644
>> --- a/arch/arm/tools/syscall.tbl
>> +++ b/arch/arm/tools/syscall.tbl
>> @@ -411,3 +411,4 @@
>>  394	common	pkey_mprotect		sys_pkey_mprotect
>>  395	common	pkey_alloc		sys_pkey_alloc
>>  396	common	pkey_free		sys_pkey_free
>> +397	common	statx			sys_statx
>> --
>> 2.11.0.24.ge6920cf
>>
>
