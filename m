From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Sep 2015 19:06:54 +0100
Subject: [PATCH 1/6] regulator: pbias: program pbias register offset in
 pbias driver
In-Reply-To: <1441190853-7133-2-git-send-email-kishon@ti.com>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
 <1441190853-7133-2-git-send-email-kishon@ti.com>
Message-ID: <20150902180654.GD5313@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 04:17:28PM +0530, Kishon Vijay Abraham I wrote:
> Add separate compatible strings for every platform and populate the
> pbias register offset in the driver data.
> This helps avoid depending on the dt for pbias register offset.

Can you respin with Tony's comment please and I'll apply?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150902/4b5d276d/attachment.sig>
