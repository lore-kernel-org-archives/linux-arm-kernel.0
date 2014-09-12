From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Sep 2014 12:50:39 -0500
Subject: [PATCH v8 3/3] phy: Add Qualcomm DWC3 HS/SS PHY driver
In-Reply-To: <1410542986-24419-4-git-send-email-agross@codeaurora.org>
References: <1410542986-24419-1-git-send-email-agross@codeaurora.org>
 <1410542986-24419-4-git-send-email-agross@codeaurora.org>
Message-ID: <20140912175039.GH8567@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 12, 2014 at 12:29:46PM -0500, Andy Gross wrote:
> This patch adds a new driver for the Qualcomm USB 3.0 PHY that exists on some
> Qualcomm platforms.  This driver uses the generic PHY framework and will
> interact with the DWC3 controller.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Kishon, this looks good to my eyes. It has no direct dependency with
dwc3 glue layer. Can you still grab this for v3.18 merge window ?


Reviewed-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/4ebff467/attachment.sig>
