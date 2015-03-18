From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Mar 2015 13:42:32 -0600
Subject: [PATCH] dt-bindings: brcm: rationalize Broadcom documentation
 naming
In-Reply-To: <1426706645-19313-1-git-send-email-sbranden@broadcom.com>
References: <1426706645-19313-1-git-send-email-sbranden@broadcom.com>
Message-ID: <5509D528.1080208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2015 01:24 PM, Scott Branden wrote:
> This patchset attempts to standarize the naming of dt-bindings
> documents based on the Broadcom vendor prefix of brcm.
>
> Although there are no guidelines currently present for how to name
> the dt-bindings document the "vendor,binding.txt" style is in use by
> some of the other vendors.

Conceptually I'm fine with this.
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

The only comment I have is that some bindings refer to other bindings, 
e.g. an I2C controller binding might refer to the core I2C binding to 
define core I2C properties. Since this patch moves a couple files 
between directories, did you double-check that none of the pathnames in 
those references need fixing up?
