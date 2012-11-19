From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 13:44:54 +0000
Subject: [PATCH v4 1/7] ARM: kernel: enhance MPIDR macro definitions
In-Reply-To: <1353329106-24084-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353329106-24084-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121119134454.GQ3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 12:45:00PM +0000, Lorenzo Pieralisi wrote:
> Kernel subsystems other than the topology layer need the MPIDR
> mask definitions to access the MPIDR without relying on hardcoded
> masks. This patch moves the MPIDR register masks definition to
> a header file and defines a macro to simplify access to MPIDR bit fields
> representing affinity levels.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
