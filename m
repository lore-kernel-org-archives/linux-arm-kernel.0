From: dennis.chen@linaro.org (Dennis Chen)
Date: Fri, 27 May 2016 16:04:22 +0800
Subject: [PATCH v7 14/15] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <1464129345-18985-15-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
 <1464129345-18985-15-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <CADKHWaeyWjagdW-T1GTFRwvXrVUpb3oLaa5qOimhd247Lk5gQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2016 at 06:35, David Daney <ddaney.cavm@gmail.com> wrote:
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
> ---

I've tested this patch on Juno board with home made SRAT and SLIT
table, so feel free to add:
Tested-by: Dennis Chen <dennis.chen@arm.com>

-- 
Regards,
Dennis
