From: tiffang@gmail.com (ikjn)
Date: Fri, 23 Jul 2010 15:53:19 +0900
Subject: debugging kernel with gdb
In-Reply-To: <20100722171504.GA7869@radix50.net>
References: <4BFD72AD.4010005@gmail.com>
	<AANLkTikwrs3PUS2zNR8daxfVkSCKLUvRtDYkXicXcTXq@mail.gmail.com>
	<4BFD7BBF.1090100@gmail.com>
	<AANLkTikfGIBaYnFskW4_TUzfWXBIy9fIqziNcedQwE8M@mail.gmail.com>
	<1279752261.15547.9.camel@qu102.quarc.com>
	<20100722171504.GA7869@radix50.net>
Message-ID: <AANLkTi=xMPJFGwkQ=4ZbiMmTsYKzPut_Q6Ztg_GG6uVW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

try -O1.
it's better

On Fri, Jul 23, 2010 at 2:15 AM, Baurzhan Ismagulov <ibr@radix50.net> wrote:
> On Wed, Jul 21, 2010 at 03:44:21PM -0700, Jeff Hane wrote:
>> The code was being compiled with -O2 and -g. ?I thought the obvious
>> thing to do is just change this to -O0 in the top level Makefile;
>> however this results in the following message.
>
> This doesn't work (I've never looked why) and is not supported.
>
> With kind regards,
> Baurzhan.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
