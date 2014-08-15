From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Aug 2014 12:41:47 +0100
Subject: [PATCH] regulator: as3722: .name field initialized twice
 differently
In-Reply-To: <1408100984-11757-1-git-send-email-peter.griffin@linaro.org>
References: <1408100984-11757-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140815114147.GK17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 12:09:44PM +0100, Peter Griffin wrote:
> Regulator AS3722_REGULATOR_ID_LDO3 and AS3722_REGULATOR_ID_LDO4
> have there .name field initialised twice with different values.
> 
> Looking at the code the second entry should have been .sname
> which is what this patch corrects.

This change appears to already be present in current code - please
submit against current code, or Linus' tree for bug fixes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140815/bf6c22ee/attachment.sig>
