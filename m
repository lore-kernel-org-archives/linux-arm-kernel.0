From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 09:00:15 -0700
Subject: [RFC 1/4] ASoC: omap: rx51: Use snd_soc_register_card
In-Reply-To: <1382909086-10493-2-git-send-email-sre@debian.org>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-2-git-send-email-sre@debian.org>
Message-ID: <20131028160015.GA13643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 10:24:43PM +0100, Sebastian Reichel wrote:
> From: Pali Roh?r <pali.rohar@gmail.com>
> 
> This patch converts the rx51 ASoC module to use
> snd_soc_register_card. It also adds module alias
> to support driver autoloading.

You should really use devm_snd_soc_register_card() here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/9750074b/attachment.sig>
