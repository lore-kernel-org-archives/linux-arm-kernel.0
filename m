From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Sep 2015 12:39:10 -0700
Subject: [PATCH v6 08/22] regulator: core: Probe regulators on demand
In-Reply-To: <1442844182-27787-9-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-9-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150921193910.GC30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 04:02:48PM +0200, Tomeu Vizoso wrote:
> When looking up a regulator through its OF node, probe it if it hasn't
> already.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/9e41f8fd/attachment.sig>
