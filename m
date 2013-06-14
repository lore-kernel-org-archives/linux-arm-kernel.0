From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Jun 2013 11:00:20 +0100
Subject: [PATCH] ASoC: Fix double assignment of .owner in struct
 snd_soc_card
In-Reply-To: <1371203336-16972-1-git-send-email-emilgoode@gmail.com>
References: <1371203336-16972-1-git-send-email-emilgoode@gmail.com>
Message-ID: <20130614100020.GH1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 11:48:56AM +0200, Emil Goode wrote:
> In struct snd_soc_card zylonite .owner is assigned THIS_MODULE
> twice, remove one of them.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/c830586d/attachment.sig>
