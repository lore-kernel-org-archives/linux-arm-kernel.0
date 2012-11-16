From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 16 Nov 2012 16:27:24 +0100
Subject: [PATCH 2/2] ARM: tegra: trimslice: enable HDMI port
In-Reply-To: <1353021614-29200-2-git-send-email-swarren@wwwdotorg.org>
References: <1353021614-29200-1-git-send-email-swarren@wwwdotorg.org>
 <1353021614-29200-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121116152723.GA28991@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 04:20:14PM -0700, Stephen Warren wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Enable host1x, and the HDMI output. Harmony also has a DVI port with an
> HDMI form-factor connector, driven by Tegra's LVDS output. This isn't
> enabled yet, due to potential issues with having multiple outputs enabled.
> 
> Correct DDC I2C frequency to 100KHz.
> 
> Add dummy/fixed regulators to satisfy the HDMI driver.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> [swarren: add commit description, remove enable of DVI port]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Heh, I suppose I can't add a Reviewed-by to a patch that was originally
my own, but this looks good to me.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/a1e3e4f8/attachment.sig>
