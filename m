From: treding@nvidia.com (Thierry Reding)
Date: Thu, 18 Feb 2016 16:12:45 +0100
Subject: [PATCH 2/2] drm/panel: Add support for LG lp120up1 panel
In-Reply-To: <1455691839-2410-2-git-send-email-jitao.shi@mediatek.com>
References: <1455691839-2410-1-git-send-email-jitao.shi@mediatek.com>
 <1455691839-2410-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <20160218151244.GB5571@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 02:50:39PM +0800, Jitao Shi wrote:
> The LG lp120up1 panel is a 12.0" 1920x1280 panel,
> which can be supported by the simple panel driver

It'd be nice to mention the type of interface of the panel here. While
at it, please rewrite the commit message to make use of what width you
have (i.e. any line after the subject can be 72 characters wide).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/1b854aba/attachment.sig>
