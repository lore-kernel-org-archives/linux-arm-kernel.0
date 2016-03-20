From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Mar 2016 19:40:18 -0500
Subject: [PATCH v3 3/3] pwm: pwm-tiehrpwm: Update dt binding document to
 use generic node name
In-Reply-To: <1458263723-25770-4-git-send-email-fcooper@ti.com>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
 <1458263723-25770-4-git-send-email-fcooper@ti.com>
Message-ID: <20160320004018.GA7611@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 08:15:23PM -0500, Franklin S Cooper Jr wrote:
> Now that the node name has been changed from ehrpwm to pwm the document
> should show this proper usage. Also change the unit address in the example
> from 0 to the proper physical address value that should be used.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 3 changes:
> N/A
> 
> Version 2 changes:
> Changed the unit address for da850 to match the value in the reg property.
> 
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
