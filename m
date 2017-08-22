From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Aug 2017 11:32:41 +0100
Subject: [PATCH v5 1/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <20170822075729.8438-2-jeffy.chen@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-2-jeffy.chen@rock-chips.com>
Message-ID: <20170822103241.wjiycavsro7abknj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 03:57:20PM +0800, Jeffy Chen wrote:
> This property is no longer used.

I would still rather keep the existing property documented (the binding
does need to be fixed) than remove it.  It's better practice and it's
not costing a huge amount.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/2779ed6d/attachment.sig>
