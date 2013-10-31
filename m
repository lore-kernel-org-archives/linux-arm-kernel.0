From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Oct 2013 00:27:51 +0000
Subject: [PATCH v3 3/4] AArch64: KGDB: Add step debugging support
In-Reply-To: <1382094469-7971-4-git-send-email-vijay.kilari@gmail.com>
References: <1382094469-7971-1-git-send-email-vijay.kilari@gmail.com>
 <1382094469-7971-4-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20131031002750.GH27743@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:07:48PM +0100, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Add KGDB software step debugging support for EL1 debug
> in AArch64 mode.
> 
> KGDB registers step debug handler with debug monitor.
> On receiving 'step' command from GDB tool, target enables
> software step debugging and step address is updated.
> If no step address is received from GDB tool, target assumes
> next step address is current PC.
> 
> Software Step debugging is disabled when 'continue' command
> is received

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
