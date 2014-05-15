From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 May 2014 12:52:35 +0200
Subject: [PATCH v2] drm/panel: add support for EDT ET057090DHU panel
In-Reply-To: <1400146725-5788-1-git-send-email-stefan@agner.ch>
References: <1400146725-5788-1-git-send-email-stefan@agner.ch>
Message-ID: <20140515105234.GJ6434@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:38:45AM +0200, stefan at agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This panel is sold by Toradex for Colibri T20/T30 and Apalis T30
> evaluation kits.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../devicetree/bindings/panel/edt,et057090dhu.txt  |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/panel/edt,et057090dhu.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/579360e2/attachment.sig>
