From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 12 Jan 2010 13:11:30 +0530
Subject: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0509417@dbde02.ent.ti.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
	<1263220628.6305.44.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
	<20100111152333.GB4109@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C0509417@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0509768@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>
> > No - Catalin means are the NZCV flags changed by the secure monitor, or
> > are they preserved?  If they're preserved, you don't need a "cc" clobber.
> > If they're not preserved, you do.
> I will double check this but IIRC the flags are preserved.
I confirm that the flags are restored. Will repost the patch with 
suggested changes.
