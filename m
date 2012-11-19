From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 13:45:29 +0000
Subject: [PATCH v4 3/7] ARM: kernel: smp_setup_processor_id() updates
In-Reply-To: <1353329106-24084-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353329106-24084-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121119134529.GS3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 12:45:02PM +0000, Lorenzo Pieralisi wrote:
> This patch applies some basic changes to the smp_setup_processor_id()
> ARM implementation to make the code that builds cpu_logical_map more
> uniform across the kernel.
> 
> The function now prints the full extent of the boot CPU MPIDR[23:0] and
> initializes the cpu_logical_map for CPUs up to nr_cpu_ids.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will
