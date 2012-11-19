From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 13:45:08 +0000
Subject: [PATCH v4 2/7] ARM: kernel: update topology to use new MPIDR
 macros
In-Reply-To: <1353329106-24084-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1353329106-24084-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353329106-24084-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121119134508.GR3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 12:45:01PM +0000, Lorenzo Pieralisi wrote:
> This patch updates the topology initialization code to use the newly
> defined accessors to retrieve the MPIDR affinity levels.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
