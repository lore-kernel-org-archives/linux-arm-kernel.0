From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 7 Feb 2017 12:02:27 -0300
Subject: [PATCH v4 1/2] perf tools arm64: Add support for generating bpf
 prologue
In-Reply-To: <20170207121232.GD1883@arm.com>
References: <20170207073412.26983-1-hekuang@huawei.com>
 <20170207121232.GD1883@arm.com>
Message-ID: <20170207150227.GI24988@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Feb 07, 2017 at 12:12:33PM +0000, Will Deacon escreveu:
> On Tue, Feb 07, 2017 at 07:34:11AM +0000, He Kuang wrote:
> > Since HAVE_KPROBES can be enabled in arm64, this patch introduces
> > regs_query_register_offset() to convert register name to offset for
> > arm64, so the BPF prologue feature is ready to use.
> > 
> > Signed-off-by: He Kuang <hekuang@huawei.com>
> > ---
> >  tools/perf/arch/arm64/Makefile          |  1 +
> >  tools/perf/arch/arm64/util/dwarf-regs.c | 15 ++++++++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> Thanks, looks ok to me now:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks, applied with your and Masami's tags.

- Arnaldo
