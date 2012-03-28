From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 11:53:10 +0100
Subject: [PATCH] Regulator: anatop-regulator: patching to device-tree
 property "reg".
In-Reply-To: <1332834841-13925-1-git-send-email-paul.liu@linaro.org>
References: <1332834841-13925-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120328105310.GG3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 03:54:01PM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Change "reg" to "anatop-reg-offset" due to there is a warning of handling no
> size field in reg.
> 
> This patch also adds the missing device-tree binding documentation.

Applied, thanks, but please do split patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/e015ecfc/attachment.sig>
