From: adrian.wenl@gmail.com (Lei Wen)
Date: Mon, 4 Jul 2011 17:27:16 +0800
Subject: [PATCH V3 0/9] pxa3xx_nand: add two chip select support
In-Reply-To: <1309342805.23597.136.camel@sauron>
References: <1309246361.23597.30.camel@sauron>
	<1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<4E0AE9B0.7000908@compulab.co.il>
	<1309342805.23597.136.camel@sauron>
Message-ID: <CALZhoSSHx_TB3UvAC6r86cPhY09+6sit5sK8OOJU8mqCg6YwAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem & Igor,

On Wed, Jun 29, 2011 at 6:20 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2011-06-29 at 12:00 +0300, Igor Grinberg wrote:
>> Hi Lei,
>>
>> On 06/29/11 06:51, Lei Wen wrote:
>>
>> > V2:
>> > Choose to at most keep original pxa3xx_nand_info structure to reduce
>> > patch size
>> >
>> > V3:
>> > Seperate original one patch into a patch set
>> >
>> > Lei Wen (9):
>> > ? MTD: pxa3xx_nand: convert all printk into dev_*
>> > ? MTD: pxa3xx_nand: enable multiple chip select support
>> > ? ARM: aspenite: fix nand platform data
>> > ? ARM: cm-x300: fix nand platform data
>> > ? ARM: colibri-pxa3xx: fix nand platform data
>> > ? ARM: littleton: fix nand platform data
>> > ? ARM: mxm8x10: fix nand platform data
>> > ? ARM: raumfeld: fix nand platform data
>> > ? ARM: zylonite: fix nand platform data
>>
>> While I agree with Artem, that reviewing patch sets are much more easier,
>> than a one single big patch, I think you should keep the
>> "fix nand platform data" changes all in one patch.
>> All of them do the same change, but for different boards.
>
> Yeah, I did not suggest to split a large patch to a number of
> micro-patches plus another large patch :-) My suggestion is to have a
> set of easily reviewable patches. If you do the same thing in many
> platform data structures, it is reviewable and can be in one patch.
>
V4 patch set has been pushed. Hope this time would be better. :)

Thanks,
Lei
