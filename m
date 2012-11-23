From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 23 Nov 2012 08:46:49 +0100 (CET)
Subject: [PATCH 425/493] scsi: remove use of __devexit
In-Reply-To: <1353349642-3677-425-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-425-git-send-email-wfp5p@virginia.edu>
Message-ID: <Pine.LNX.4.64.1211230845540.14984@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

>  drivers/scsi/tmscsim.c                    | 2 +-

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
