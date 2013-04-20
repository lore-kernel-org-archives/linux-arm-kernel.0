From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 20 Apr 2013 09:54:01 +0800
Subject: [PATCH] ARM64: kernel: compiling issue: need define readq and
 writeq for driver module using.
In-Reply-To: <20130419123513.GB18443@arm.com>
References: <51712975.8030104@asianux.com> <20130419123513.GB18443@arm.com>
Message-ID: <5171F539.90604@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?19? 20:35, Catalin Marinas wrote:
> On Fri, Apr 19, 2013 at 12:24:37PM +0100, Chen Gang wrote:
>> > 
>> >   when compiling with allmodconfig, CONFIG_64BIT=y
>> >     the file drivers/base/regmap/regmap-mmio.c will use readq and writeq.
>> > 
>> >   so we need implement these functions.
>> > 
>> > BTW:
>> >   the coding style can not pass ./scripts/checkpatch.pl.
>> >   it seems better to provide additional patch for beautifying code.
> If it complains about long lines, just ignore it. I wouldn't worry too
> much about checkpatch.pl and coding style warnings ;)
> 

  ok, I can understand.

  :-)

-- 
Chen Gang

Asianux Corporation
