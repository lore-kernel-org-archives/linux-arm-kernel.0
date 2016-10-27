From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 27 Oct 2016 10:13:02 +0100
Subject: [PATCH 9/9] Input: wm97xx: add new AC97 bus support
In-Reply-To: <1477510907-23495-10-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-10-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161027091302.GH28180@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 09:41:47PM +0200, Robert Jarzmik wrote:
> This adds support for the new AC97 bus code, which discovers the devices
> rather than uses platform data.
> 
> As part of this discovery, it enables a multi-function device wm97xx,
> which supports touchscreen, battery, ADC and an audio codec. This patch
> adds the code to bind the touchscreen "cell" as the touchscreen driver.
> 
> This was tested on the pxa architecture with a pxa270 + wm9713 + the
> mioa701 touchscreen.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
