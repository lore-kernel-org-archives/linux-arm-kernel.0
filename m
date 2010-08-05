From: bahadir@l4dev.org (Bahadir Balban)
Date: Thu, 05 Aug 2010 17:23:46 +0300
Subject: cpu_get_pgd()
Message-ID: <4C5AC972.4010109@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a call to cpu_get_pgd() from do_translation_fault()
that reads the TTBR to reach the pgd pointer.

Why not use pgd_offset(current->mm, addr)?

Thanks,

-- 
Bahadir
