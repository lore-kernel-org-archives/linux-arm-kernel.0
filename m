From: figure1802@126.com (FF)
Date: Wed, 17 Jan 2018 12:13:08 +0800 (CST)
Subject: [PATCH v3 07/20] arm64: mm: Allocate ASIDs in pairs
In-Reply-To: <27699ff3.2a02.160fcc87182.Coremail.figure1802@126.com>
References: <27699ff3.2a02.160fcc87182.Coremail.figure1802@126.com>
Message-ID: <40f9df1.48df.161025212b6.Coremail.figure1802@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


At 2018-01-16 10:24:42, "FF" <figure1802@126.com> wrote:
>hi?all:
>why we use two? ASID for a?process? what is the benefits?
>After KPTI, the kernel?space?mapping?become?non-Global TLB (process-specific TLB)? so we need?one ASID for? process?running in?userspace?
>and other ASID?for process?running in?kernel?space? it will?switch the ASID when a process? switching?to/form?userpsace?
>
>
>what is the benefits add?exception trampoline page? it will performance regression?
>

anyone can help to confirm?

Thanks,
FF
