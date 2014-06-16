From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jun 2014 11:14:45 +0100
Subject: [PATCH v14 01/10] [media] v4l2: add new V4L2_PIX_FMT_RGB666
 pixel format.
In-Reply-To: <1402913484-25910-1-git-send-email-denis@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
Message-ID: <20140616101445.GW23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 12:11:15PM +0200, Denis Carikli wrote:
> That new macro is needed by the imx_drm staging driver
>   for supporting the QVGA display of the eukrea-cpuimx51 board.

As I said probably around v10 time, I already have this patch queued,
and I was going to send it to Greg before the previous merge window,
but due to the number of patches I was already carrying, it was lost
amongst the trees.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
