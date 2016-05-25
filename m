From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 May 2016 15:42:57 +0100
Subject: [PATCH v7 14/15] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <1464129345-18985-15-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
 <1464129345-18985-15-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160525144256.GG5996@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 03:35:44PM -0700, David Daney wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Introduce a new file to hold ACPI based NUMA information parsing from
> SRAT and SLIT.
> 
> SRAT includes the CPU ACPI ID to Proximity Domain mappings and memory
> ranges to Proximity Domain mapping.  SLIT has the information of inter
> node distances(relative number for access latency).
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> [rrichter at cavium.com Reworked for numa v10 series ]
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> [david.daney at cavium.com reorderd and combinded with other patches in
> Hanjun Guo's original set, removed get_mpidr_in_madt() and use
> acpi_map_madt_entry() instead.]
> Signed-off-by: David Daney <david.daney@cavium.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
