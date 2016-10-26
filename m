From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 15:49:06 +0530
Subject: [PATCH v6 4/5] ARM: DTS: da850: Add cfgchip syscon node
In-Reply-To: <1477451211-31979-5-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-5-git-send-email-david@lechnology.com>
Message-ID: <2f80bc2f-79ef-bed8-0c7f-1003e0efe781@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 October 2016 08:36 AM, David Lechner wrote:
> Add a syscon node for the SoC CFGCHIPn registers. This is needed for
> the new usb phy driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.10/dt. Changed "DTS" in subject line to small case. ARM
device-tree patches have been following that.

Thanks
Sekhar
