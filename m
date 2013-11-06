From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Nov 2013 10:03:05 +0000
Subject: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131106100305.GI11602@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 08:59:53AM +0000, Li Xiubo wrote:

Please fix your mailer to word wrap within paragraphs.

> The SGTL5000 is based on regulators and when it is disabled, there
> will be an error returns directly while the SGTL5000 codec is probing.

What makes you say this?  That's not how the regulator API works.  Have
you actually seen any problems?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/3e04c897/attachment.sig>
