From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 16:43:39 +0000
Subject: [patch v11 02/23] ACPI: add arm64 to the platforms that use
 ioremap
In-Reply-To: <1427205776-5060-3-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325164339.GA14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:35PM +0800, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Now with the base changes to the arm memory mapping it is safe
> to convert to using ioremap to map in the tables after
> acpi_gbl_permanent_mmap is set.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Another long flight, so I'm adding some acks (unless Will merged these
patches already).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
