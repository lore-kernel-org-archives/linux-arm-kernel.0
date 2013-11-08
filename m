From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Nov 2013 14:14:08 +0000
Subject: [PATCH v4 2/4] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <1383641146-27274-3-git-send-email-vijay.kilari@gmail.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
 <1383641146-27274-3-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20131108141407.GH17461@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 08:45:44AM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Add KGDB debug support for kernel debugging.
> With this patch, basic KGDB debugging is possible.GDB register
> layout is updated and GDB tool can establish connection with
> target and can set/clear breakpoints.

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
