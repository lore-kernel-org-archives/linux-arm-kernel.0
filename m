From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 15 Jun 2016 00:09:12 +0200
Subject: [PATCH v2 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C
In-Reply-To: <20160613143134.GB1603@katana>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <20160613143134.GB1603@katana>
Message-ID: <20160614220912.GA5528@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Confirmed :( Got today only this far that the ENODEV comes from the PFC
> driver. CONFIG_DEBUG_PINCTRL is a good idea for further debugging
> probably.

Correction, it seems the pinctrl handle gets mixed up, so the
devm_pinctrl_get_select() fails. Does that match your findings?
Pity I can't access my boards for the rest of the week :(

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/37e0a63e/attachment.sig>
