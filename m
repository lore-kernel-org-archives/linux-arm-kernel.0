From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Nov 2012 10:44:44 +0900
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <CACRpkdaNmBpfONDpt7zFqLaqfiGm+ELpO-v5gZmM0rEi_AzijQ@mail.gmail.com>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <20121121013133.GE4673@opensource.wolfsonmicro.com>
 <CACRpkdaNmBpfONDpt7zFqLaqfiGm+ELpO-v5gZmM0rEi_AzijQ@mail.gmail.com>
Message-ID: <20121123014443.GD4385@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 09:57:22AM +0100, Linus Walleij wrote:

> Is it correct to assume that this library will be useful also for ALSA
> SoC type of devices?

ASoC has facilities for autogenerating the bulk of the sequences which
with modern devices is all that you really need.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/6c6389e6/attachment.sig>
