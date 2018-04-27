From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 27 Apr 2018 16:59:48 +0200
Subject: [PATCH v4 3/4] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
In-Reply-To: <1522174414-30380-4-git-send-email-roy.pledge@nxp.com>
References: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
 <1522174414-30380-4-git-send-email-roy.pledge@nxp.com>
Message-ID: <20180427145948.GB12750@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 02:13:33PM -0400, Roy Pledge wrote:
> Move the NXP DPIO (Datapath I/O Driver) out of the
> drivers/staging directory and into the drivers/soc/fsl directory.
> 
> The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
> hardware on NXP DPAA2 devices. This is a prerequisite to moving the
> DPAA2 Ethernet driver out of staging.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Ah, this needs to go in before the ethernet driver can move out, sorry
about that.

Can you redo these last two patches against my staging-next branch so
that we have a chance that they will apply?

thanks,

greg k-h
