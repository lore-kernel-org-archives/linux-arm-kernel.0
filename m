From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 19 Mar 2017 20:51:12 +0000
Subject: [PATCH] ARM: wire up statx syscall
References: <20170317094204.15630-1-chris.packham@alliedtelesis.co.nz>
 <20170317095945.GY21222@n2100.armlinux.org.uk>
 <a1a1f1cccadb48d599ac9ac013ee7fab@svr-chch-ex1.atlnz.lc>
 <20170319204648.GZ21222@n2100.armlinux.org.uk>
Message-ID: <35211f89b4ab497aa02679b1611ea65a@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 09:47, Russell King - ARM Linux wrote:
> On Sun, Mar 19, 2017 at 08:12:48PM +0000, Chris Packham wrote:
>> On 17/03/17 23:00, Russell King - ARM Linux wrote:
>>> You obviously have not looked in linux-next.
>>
>> No I haven't. But even now I see nothing in
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>
> Hmm, looks like our regular linux-next updates stop at 10th March,
> which is rather unfortunate.  If it was being updated, it would have
> been in there.
>
> If not, in order to see what I currently have merged for linux-next:
>
>   http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=for-next
>

OK I see it now. By the way the table based syscall stuff is great.
