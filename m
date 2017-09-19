From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 13:28:03 +0100
Subject: [RESEND PATCH v2 3/3] ASoC: rockchip: Init dapm routes dynamically
In-Reply-To: <20170918111801.12881-3-jeffy.chen@rock-chips.com>
References: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
 <20170918111801.12881-3-jeffy.chen@rock-chips.com>
Message-ID: <20170919122803.kybaln43yho3deih@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 07:18:01PM +0800, Jeffy Chen wrote:
> Currently we are using a fixed list of dapm routes.
> 
> Init dapm routes dynamically when parsing dailinks, since we are
> supporting optional codecs.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/976db638/attachment.sig>
