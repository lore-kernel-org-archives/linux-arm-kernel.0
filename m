From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2009 21:14:23 +0100
Subject: SMP: BUG with PREEMPT enabled
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB2555BF@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254F8D@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BB2555BF@dbde02.ent.ti.com>
Message-ID: <20091014201423.GC28948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 04:56:18PM +0530, Shilimkar, Santosh wrote:
> Here is the patch I used to fix this BUG.

Patch is good.  Could you send it to the patch system.  Please note that
the patch system now almost accepts standard patch submissions (in other
words, it no longer requires the "PATCH FOLLOWS" tag.)  However, it still
requires the "KernelVersion:" tag to appear somewhere before the patch.
