From: figure1802@126.com (figo.zhang)
Date: Tue, 16 Jan 2018 10:24:42 +0800 (CST)
Subject: [PATCH v3 07/20] arm64: mm: Allocate ASIDs in pairs
Message-ID: <27699ff3.2a02.160fcc87182.Coremail.figure1802@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi?all:
why we use two? ASID for a?process? what is the benefits?
After KPTI, the kernel?space?mapping?become?non-Global TLB (process-specific TLB)? so we need?one ASID for? process?running in?userspace?
and other ASID?for process?running in?kernel?space? it will?switch the ASID when a process? switching?to/form?userpsace?


what is the benefits add?exception trampoline page? it will performance regression?


Best
Figure
