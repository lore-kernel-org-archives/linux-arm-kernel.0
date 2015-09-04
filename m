From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Sep 2015 16:17:32 +0100
Subject: [PATCH v3 1/2] regulator: pbias: program pbias register offset
 in pbias driver
In-Reply-To: <1441368025-21182-2-git-send-email-kishon@ti.com>
References: <1441368025-21182-1-git-send-email-kishon@ti.com>
 <1441368025-21182-2-git-send-email-kishon@ti.com>
Message-ID: <20150904151732.GN5313@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 05:30:24PM +0530, Kishon Vijay Abraham I wrote:
> Add separate compatible strings for every platform and populate the
> pbias register offset in the driver data.
> This helps avoid depending on the dt for pbias register offset.

If there are any changes from the already applied patch for this please
send an incremental patch.  Please don't resend already applied patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150904/e4f42a86/attachment-0001.sig>
