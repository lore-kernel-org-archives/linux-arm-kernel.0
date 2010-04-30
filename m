From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Apr 2010 10:37:14 +0100
Subject: [2.6.34-rc6] ARM: build breaks with KPROBES
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5217AC1@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C52179C0@dbde02.ent.ti.com>
	<20100430074745.GA7874@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5217AC1@dbde02.ent.ti.com>
Message-ID: <20100430093714.GA30392@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 02:57:20PM +0530, Shilimkar, Santosh wrote:
> >From 2660d4ca5d77406fc8d46a5c0f18127332914604 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 30 Apr 2010 12:41:16 +0530
> Subject: [PATCH] ARM: Fix build break with KPROBES enabled
> 
> With CONFIG_KPROBES enabled two section are getting created which
> leads to below build break.

Ok.
