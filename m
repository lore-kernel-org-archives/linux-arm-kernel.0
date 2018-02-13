From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Feb 2018 09:21:23 +0100
Subject: [PATCH v5 10/26] ARM: shmobile: rcar-gen2: Add watchdog support
In-Reply-To: <1518457475-4480-11-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-11-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180213082123.cypqig74ksyewhln@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 05:44:19PM +0000, Fabrizio Castro wrote:
> This patch adds watchdog support by installing shmobile_boot_vector_gen2
> to ICRAM1 when enough memory is available, in which case we also keep a
> copy of MPIDR to complete the reset vector logic.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I am marking this patch as deferred as it has dependencies on watchdog driver
and in turn clock changes in this series.
