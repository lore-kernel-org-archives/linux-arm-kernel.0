From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 10 Nov 2014 12:48:09 +0000
Subject: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle
 states
In-Reply-To: <54606D1C.3000300@linaro.org>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7hbnp6e81x.fsf@deeprootsystems.com>
 <20141021162058.GA17610@e102568-lin.cambridge.arm.com>
 <54606D1C.3000300@linaro.org>
Message-ID: <20141110124809.GB15484@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 07:45:32AM +0000, Daniel Lezcano wrote:
> On 10/21/2014 06:20 PM, Lorenzo Pieralisi wrote:
> > On Mon, Oct 20, 2014 at 10:38:02PM +0100, Kevin Hilman wrote:
> >> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> >>
> >>> On some platforms the device tree bindings must provide the kernel
> >>> with a status flag for idle states, that defines whether the idle
> >>> state is operational or not in the current configuration.
> >>>
> >>> This patch adds a status property to the ARM idle states compliant
> >>> with ePAPR v1.1 and updates the DT parsing code accordingly.
> >>>
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>
> >> For the series:
> >>
> >> Acked-by: Kevin Hilman <khilman@linaro.org>
> >
> > Thanks ! I will queue it for 3.19 then.
> 
> Applied to my tree for 3.19.
> 
> Thanks
>    -- Daniel

Thank you !

Lorenzo
