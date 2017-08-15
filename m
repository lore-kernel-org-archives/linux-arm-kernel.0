From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Aug 2017 18:14:24 +0100
Subject: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
In-Reply-To: <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 03:06:50PM -0700, Lori Hikichi wrote:
> Allow each audio port to select which clock (if any) it wants to use.

Why is this in DT for the port and not either using standard clock
bindings to configure the clock tree or allowing the machine driver to
pick?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/d38a3b7e/attachment.sig>
