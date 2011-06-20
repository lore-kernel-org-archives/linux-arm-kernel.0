From: vitalivanov@gmail.com (Vitaliy Ivanov)
Date: Mon, 20 Jun 2011 19:44:46 +0300
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate linux/leds.h
	include
In-Reply-To: <alpine.LNX.2.00.1106201608460.11049@pobox.suse.cz>
References: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
	<4DFF1AA5.80508@ru.mvista.com>
	<alpine.LNX.2.00.1106201232530.18991@swampdragon.chaosbits.net>
	<1308566964.13261.14.camel@vivanov>
	<alpine.LNX.2.00.1106201608460.11049@pobox.suse.cz>
Message-ID: <BANLkTimfWxPm6EC9PZvqaqELz1gf-0iVLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 5:09 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 20 Jun 2011, Vitaliy Ivanov wrote:
>
>> Giri,
>>
>> I would still recommend to use the following patch as it corrects many
>> other places for trivial includes duplication. Also I was the first who
>> sent it:).
>
> Unfortunately I haven't been copied on it.
>
>> --
>> From: Vitaliy Ivanov <vitalivanov@gmail.com>
>>
>> Many stupid corrections of duplicated includes based on the output of scripts/checkincludes.pl.
>>
>> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
>
> I have applied it, and after performing build tests I will be pushing it
> out.

Thanks Jiri. Can see it in your tree already. The patch itself is
absolutely harmless except of one non usual correction to
cyashalomap_kernel.h.

- Vitaliy
