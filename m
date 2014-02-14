From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Feb 2014 10:17:25 +0000
Subject: [PATCH v3] ARM: mm: report both sections from PMD
In-Reply-To: <20140213195230.GA15275@www.outflux.net>
References: <20140213195230.GA15275@www.outflux.net>
Message-ID: <20140214101724.GC10590@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 07:52:30PM +0000, Kees Cook wrote:
> On 2-level page table systems, the PMD has 2 section entries. Report
> these, otherwise ARM_PTDUMP will miss reporting permission changes on
> odd section boundaries.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
