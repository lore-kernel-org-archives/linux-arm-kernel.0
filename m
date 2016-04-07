From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Apr 2016 20:03:43 +0530
Subject: [PATCH 1/3] dt: davinci: use proper address after @
In-Reply-To: <1459525325-25470-2-git-send-email-petr@barix.com>
References: <1459525325-25470-1-git-send-email-petr@barix.com>
 <1459525325-25470-2-git-send-email-petr@barix.com>
Message-ID: <57066FC7.1030706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 April 2016 09:12 PM, Petr Kulhavy wrote:
> From: David Lechner <david@lechnology.com>
> 
> TI has been using the physical address in DT after the @ in device nodes.
> The device tree convention is to use the same address that is used for
> the reg property. This updates all davinci DT files to use the proper
> convention.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for v4.7. Fixed the subject prefix to "ARM: dts: davinci: " as
is the convention for device tree updates.

Regards,
Sekhar
