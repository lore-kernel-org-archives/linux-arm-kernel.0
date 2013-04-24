From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Apr 2013 09:22:37 +0100
Subject: [PATCH] arm64: compiling issue, need add include/asm/vga.h file
In-Reply-To: <5177551D.8090007@asianux.com>
References: <5177551D.8090007@asianux.com>
Message-ID: <20130424082237.GA23397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 04:44:29AM +0100, Chen Gang wrote:
> For compiling with allmodconfig, need vga.h file, so copy it from arm32.

I would rather use the generic vga.h. We don't even have a vga_base
defined.

-- 
Catalin
