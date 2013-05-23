From: broonie@kernel.org (Mark Brown)
Date: Thu, 23 May 2013 10:18:16 -0500
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <20130523144453.GL22683@gmail.com>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <20130522155347.GJ1627@sirena.org.uk>
 <20130522165353.GB18714@gmail.com>
 <20130522174516.GT1627@sirena.org.uk>
 <20130523070905.GD18714@gmail.com>
 <20130523142419.GG2412@sirena.org.uk>
 <20130523144453.GL22683@gmail.com>
Message-ID: <20130523151816.GB6406@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 03:44:53PM +0100, Lee Jones wrote:

> Well, whatever happens I'm going to be able to refactor the driver in
> the -rc:s, so we still need this fix, or the world will end.

Why is it so invasive to have the driver cope with absent constraints?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130523/991bec63/attachment.sig>
