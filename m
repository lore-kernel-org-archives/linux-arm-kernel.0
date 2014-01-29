From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Jan 2014 10:55:46 +0000
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
References: <1390908022-10287-1-git-send-email-vijay.kilari@gmail.com>
 <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140129105546.GC26622@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 11:20:17AM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Add macros to enable and disable to manage PSTATE.D
> for debugging. The macros local_dbg_save and local_dbg_restore
> are moved to irqflags.h file
> 
> KGDB boot tests fail because of PSTATE.D is masked.
> unmask it for debugging support
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
