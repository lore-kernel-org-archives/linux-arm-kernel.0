From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Aug 2017 15:56:07 +0100
Subject: [PATCH v2 3/3] dt-bindings: ASoC: rockchip: Add
 rockchip,codec-names property
In-Reply-To: <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-4-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170810145607.g663oq7cfxjmaxtf@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:54:58PM +0800, Jeffy Chen wrote:
> Add a new rockchip,codec-names property, so that the driver can parse
> the codecs by name.

Why?  You're already referencing the CODECs by phandle and these names
are not part of any ABI...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/30656a3a/attachment.sig>
