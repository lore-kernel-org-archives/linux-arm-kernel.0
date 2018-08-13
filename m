From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 13 Aug 2018 18:55:49 +0200
Subject: [PATCH v8 0/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180813165548.GE28360@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09, Ravi Bangoria wrote:
>
> Ravi Bangoria (6):
>   Uprobes: Simplify uprobe_register() body
>   Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()
>   Uprobes: Support SDT markers having reference count (semaphore)
>   Uprobes/sdt: Prevent multiple reference counter for same uprobe
>   trace_uprobe/sdt: Prevent multiple reference counter for same uprobe

OK, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

>   perf probe: Support SDT markers having reference counter (semaphore)

I didn't even try to read this patch.

Oleg.
