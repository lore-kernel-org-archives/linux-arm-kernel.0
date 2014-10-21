From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Oct 2014 17:20:58 +0100
Subject: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle
 states
In-Reply-To: <7hbnp6e81x.fsf@deeprootsystems.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7hbnp6e81x.fsf@deeprootsystems.com>
Message-ID: <20141021162058.GA17610@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:38:02PM +0100, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On some platforms the device tree bindings must provide the kernel
> > with a status flag for idle states, that defines whether the idle
> > state is operational or not in the current configuration.
> >
> > This patch adds a status property to the ARM idle states compliant
> > with ePAPR v1.1 and updates the DT parsing code accordingly.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> For the series:
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks ! I will queue it for 3.19 then.

Lorenzo
