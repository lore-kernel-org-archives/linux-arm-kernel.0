From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 25 Aug 2011 18:45:43 +0200 (CEST)
Subject: [PATCH 0/2] i.MX3: support multi-size buffers in V4L
In-Reply-To: <1314211292-10414-1-git-send-email-g.liakhovetski@gmx.de>
References: <1314211292-10414-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <Pine.LNX.4.64.1108251838090.17190@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supporting new V4L2 ioctl()s in the mx3_camera driver also requires an 
extension for the ipu-idmac dmaengine driver. The original thread, adding 
the ioctl()s can be found here:

http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/37143

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
