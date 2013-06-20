From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Jun 2013 12:21:08 +0100
Subject: [PATCH v1 2/3] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <CAKrE-KciiPe5Zx7ggxzh=x0xY0xGDhX+=Lt7aL-EgkxinO214w@mail.gmail.com>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
 <1369032694-13183-3-git-send-email-ks.giri@samsung.com>
 <20130619182354.GD1403@sirena.org.uk>
 <CAKrE-KciiPe5Zx7ggxzh=x0xY0xGDhX+=Lt7aL-EgkxinO214w@mail.gmail.com>
Message-ID: <20130620112107.GD27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 02:52:07PM +0530, Girish KS wrote:

> Reversing the default assignment for "sdd->cs_gpio" and the following
> "if condition" shall handle both dt and non-dt case. Will do it and
> resubmit only this patch in the series.

You'll need to resend patch 3 as well, I stopped due to this one not
working.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/9a7e9649/attachment.sig>
