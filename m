From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Jun 2013 23:21:57 +0300
Subject: [PATCH 03/12] usb: otg: msm: Convert to clk_prepare/unprepare
In-Reply-To: <1370373938-32417-4-git-send-email-sboyd@codeaurora.org>
References: <1370373938-32417-1-git-send-email-sboyd@codeaurora.org>
 <1370373938-32417-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130604202157.GD28302@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 04, 2013 at 12:25:29PM -0700, Stephen Boyd wrote:
> Add calls to clk_prepare and unprepare so that MSM can migrate to
> the common clock framework.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

it's best if this goes with the rest of the series, for that:


Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/d5e8e3f8/attachment.sig>
