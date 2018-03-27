From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 00:33:35 +0200
Subject: [PATCH] pwm: mediatek: remove redundant MODULE_ALIAS entries
In-Reply-To: <0fbf589c69bc584c46c683ee7fa38d80e04624f6.1522055092.git.sean.wang@mediatek.com>
References: <0fbf589c69bc584c46c683ee7fa38d80e04624f6.1522055092.git.sean.wang@mediatek.com>
Message-ID: <20180327223334.GI28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 06:02:01PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
> 
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/9459297d/attachment.sig>
