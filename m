From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 31 Oct 2017 09:40:21 +0200
Subject: [PATCH v4 0/3] media: ov7740: Add a V4L2 sensor-level driver
In-Reply-To: <20171031011146.6899-1-wenyou.yang@microchip.com>
References: <20171031011146.6899-1-wenyou.yang@microchip.com>
Message-ID: <20171031074020.udssku6pazxooa7q@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

On Tue, Oct 31, 2017 at 09:11:42AM +0800, Wenyou Yang wrote:
> Add a Video4Linux2 sensor-level driver for the OmniVision OV7740
> VGA camera image sensor.

For the next version, could you rearrange your patches a bit as follows:

1. DT bindings
2. The driver and MAINTAINERS entry

Putting the MAINTAINERS entry separately from the driver emits a warning
from checkpatch.pl. Bindings are naturally separate from driver and should
precede the driver as the driver musn't use undocumented bindings.

Thanks.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
