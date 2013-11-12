From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 Nov 2013 15:10:20 -0800
Subject: [PATCH v2 10/19] mtd: sh_flctl: Enable the driver on all ARM
 platforms
In-Reply-To: <1383086274-11049-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131112231020.GA9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 11:37:45PM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> COMPILE_TEST.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd at lists.infradead.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied to l2-mtd.git, branch 'next' (for 3.14). Thanks.

Brian
