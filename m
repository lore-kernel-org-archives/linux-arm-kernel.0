From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 14 Apr 2017 10:42:51 +0800
Subject: [PATCH v2] ARM: dts: imx: ventana: fix DTC warnings
In-Reply-To: <1491857890-10554-1-git-send-email-tharvey@gateworks.com>
References: <1491252168-7934-1-git-send-email-tharvey@gateworks.com>
 <1491857890-10554-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20170414024247.GA14915@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 01:58:10PM -0700, Tim Harvey wrote:
> Remove the sky2 ethernet device node from the pcie controller which was
> invalid to begin with.
> 
> The original intent was to allow the bootloader to populate the MAC via
> dt but this requires the PCI bus topology to be complete in dt as well
> and as these boards have an expansion connector that topology is dynamic
> and can't be represented here.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
