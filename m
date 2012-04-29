From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 29 Apr 2012 19:07:28 +0200
Subject: [PATCH 2/3] pwm-imx: set chip.dev to prevent probe failure
In-Reply-To: <1335713330-6488-2-git-send-email-eric@eukrea.com>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
 <1335713330-6488-2-git-send-email-eric@eukrea.com>
Message-ID: <20120429170728.GB29827@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric B?nard wrote:
> else pwmchip_add fails
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

Are you okay with me folding your patch into the i.MX patch in the existing
series?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120429/43c92787/attachment.sig>
