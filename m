From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 23 Oct 2009 03:49:04 +0800
Subject: zaurus: cleanup sharpsl_pm.c
In-Reply-To: <20091022193532.GC6611@elf.ucw.cz>
References: <20091006200339.GA1538@ucw.cz> <20091017163627.GB1423@ucw.cz>
	<f17812d70910200859v6d18e81bs2760d8af1d8da5bf@mail.gmail.com>
	<f17812d70910220705o9f4a0ddwa22157b59a519350@mail.gmail.com>
	<20091022174816.GC5325@elf.ucw.cz>
	<f17812d70910221126k50c4ea7em9d58f6e85db884ae@mail.gmail.com>
	<20091022191954.GB6611@elf.ucw.cz>
	<f17812d70910221228y6613ff5eg813129b37ccfe0a1@mail.gmail.com>
	<20091022193532.GC6611@elf.ucw.cz>
Message-ID: <f17812d70910221249p98d9cc3n30b27cd9a86254b0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 3:35 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > Well, I'd say that the sharing leads to some very ugly code. ... so
>> > I'd preer it unshared.
>> >
>>
>> I suggest to re-name it to "sharpsl_" something instead of "spitz_",
>> to be less confusing at this moment.
>
> Yep, but lets do that as next patch, ok?
>
>> > But if you would prefer, I can prepare patch without the table
>> > moving...?
>>
>> That would be appreciated.
>
> Here it is.

Applied.
