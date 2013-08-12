From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Aug 2013 11:46:52 +0100
Subject: [PATCH 2/5] ARM: pxa: ssp: add shortcut for &pdev->dev
In-Reply-To: <5208BBE5.5050306@gmail.com>
References: <1376296638-19804-1-git-send-email-zonque@gmail.com>
 <1376296638-19804-3-git-send-email-zonque@gmail.com>
 <20130812103834.GO6427@sirena.org.uk> <5208BBE5.5050306@gmail.com>
Message-ID: <20130812104652.GP6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 12:41:41PM +0200, Daniel Mack wrote:

> Which tree will you merge them through? ASoC?

Yes.

> I actually thought Haojian would pick them, but I see there's a build
> dependency. So it might make sense if you take them instead.

They didn't obviously touch arch/arm so I'd expect them to go through
the relevant driver tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/12b9a500/attachment.sig>
