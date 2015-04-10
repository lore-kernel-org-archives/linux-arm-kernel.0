From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 10 Apr 2015 14:07:34 -0700
Subject: [PATCH v3 09/11] ARM: dts: apq8064-ifc6410: Add DT alias for
 serial port
In-Reply-To: <1428698671-12282-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428698491-11881-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1428698671-12282-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150410210734.GR19186@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 10 Apr 13:44 PDT 2015, Srinivas Kandagatla wrote:

> From: Pramod Gurav <pramod.gurav@smartplayin.com>
> 
> Define an alias for serial port present on ifc6410 which is used as
> console.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> [Srinivas Kandagatla: renamed the serial0 label appropriately]
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---

The order of the sobs should be reversed, your name should be last as
you're the last one touching the patch.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
