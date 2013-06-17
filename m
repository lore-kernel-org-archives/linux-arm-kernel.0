From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Jun 2013 10:06:47 +0100
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.11
In-Reply-To: <20130614222519.GK17326@quad.lixom.net>
References: <1371193161-25224-1-git-send-email-nsekhar@ti.com>
 <20130614222519.GK17326@quad.lixom.net>
Message-ID: <20130617090647.GX1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 03:25:19PM -0700, Olof Johansson wrote:

> Ok. I'll hold off since Mark was interested in seeing the code. Please resend
> once you have acks.

It should be OK to go.  I did actually find a bug when reviewing but the
fix was to remove the offending driver since it's been broken for years.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/e6363d43/attachment.sig>
