From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 24 Apr 2013 19:06:03 +0800
Subject: [PATCH v3] arm64: compiling issue, need add include/asm/vga.h file
In-Reply-To: <20130424110511.GK23397@arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com>
 <20130424102327.GF21850@mudshark.cambridge.arm.com>
 <5177BAD0.9000500@asianux.com> <20130424110511.GK23397@arm.com>
Message-ID: <5177BC9B.1060103@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?24? 19:05, Catalin Marinas wrote:
> On Wed, Apr 24, 2013 at 11:58:24AM +0100, Chen Gang wrote:
>> > 
>> > For compiling with allmodconfig, need vga.h file, so generate it which
>> > just only include the asm-generic one.
>> > 
>> > It is firstly used by drivers/gpu/drm/drm_irq.c.
>> > 
>> > The related error:
>> > include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Looks fine. Thanks.

Thanks, too.

-- 
Chen Gang

Asianux Corporation
