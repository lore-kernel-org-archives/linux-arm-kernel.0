From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 22 Nov 2012 11:36:14 +0100
Subject: [PATCH 133/493] remove use of __devexit_p
In-Reply-To: <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
Message-ID: <1908907.vq9PYUkhpZ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 November 2012 13:21:22 Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

[snip]

>  drivers/media/platform/omap3isp/isp.c                    | 2 +-

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
