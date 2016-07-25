From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jul 2016 17:21:25 +0200
Subject: [PATCH 2/2] dt-bindings: add simple-panel-dsi and simple-panel
In-Reply-To: <1468984730-23186-2-git-send-email-mark.yao@rock-chips.com>
References: <1468984730-23186-1-git-send-email-mark.yao@rock-chips.com>
 <1468984730-23186-2-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20160725152125.GS21170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 11:18:50AM +0800, Mark Yao wrote:
> Allow user add display timing on device tree with simple-panel-dsi
> or simple-panel.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  .../bindings/display/panel/simple-panel.txt        | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Sorry, not going to happen. Read this for an explanation of why not:

	https://sietch-tagr.blogspot.de/2016/04/display-panels-are-not-special.html

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/42a90bff/attachment.sig>
