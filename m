From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 09:51:24 +0200
Subject: [PATCH v3 4/6] pwm: bindings: add MT2712/MT7622 information
In-Reply-To: <1498802721-32455-5-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-5-git-send-email-zhi.mao@mediatek.com>
Message-ID: <20170821075124.GN18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:05:19PM +0800, Zhi Mao wrote:
> add MT2712/MT7622 pwm information

Please avoid duplicating the subject in the description. You're not
adding any meaningful information. I've changed the commit to this:

--- >8 ---
dt-bindings: pwm: Add MT2712/MT7622 information

Enhance the MediaTek PWM binding with details about the IP found in the
MT2712 and MT7622 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
--- 8< ---

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/73927736/attachment.sig>
