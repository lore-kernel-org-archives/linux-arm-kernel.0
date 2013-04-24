From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 24 Apr 2013 16:44:54 +0800
Subject: [PATCH] arm64: compiling issue, need add include/asm/vga.h file
In-Reply-To: <20130424082237.GA23397@arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
Message-ID: <51779B86.4030306@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?24? 16:22, Catalin Marinas wrote:
> On Wed, Apr 24, 2013 at 04:44:29AM +0100, Chen Gang wrote:
>> For compiling with allmodconfig, need vga.h file, so copy it from arm32.
> 
> I would rather use the generic vga.h. We don't even have a vga_base
> defined.
> 

OK, thanks. I need send patch v2.

-- 
Chen Gang

Asianux Corporation
