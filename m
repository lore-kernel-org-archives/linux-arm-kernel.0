From: bahadir@l4dev.org (Bahadir Balban)
Date: Mon, 11 Jan 2010 21:59:09 +0200
Subject: Split page tables
Message-ID: <4B4B830D.20309@l4dev.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

If split page tables were used in v6/v7, there might have been 
significant page table area savings e.g. 8KB * 256 = 2MB on a 256 
address space system with a 2GB task address space. This also seems to 
bring the relief of not having to map global mappings to every page 
table at run-time. Why wasn't this route chosen? Perhaps because it 
needs the TASK_SIZE to become smaller? Whatif it was made 0x8000 0000?

Thanks,

Bahadir
