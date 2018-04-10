From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 10 Apr 2018 20:28:13 +0200 (CEST)
Subject: [PATCH 1/3] drm/vc4: Remove the need for the GPU-subsystem DT
 node.
In-Reply-To: <20180409230040.1100-1-eric@anholt.net>
References: <20180409230040.1100-1-eric@anholt.net>
Message-ID: <8806871.109949.1523384893773@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 10. April 2018 um 01:00 geschrieben:
> 
> 
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.

i didn't test it. Does the code change keep the backward compatibility with older DT?
