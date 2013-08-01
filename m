From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Aug 2013 10:53:38 +0100
Subject: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
In-Reply-To: <51F98CBC.6000302@wwwdotorg.org>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
 <51F7FBA8.6080400@wwwdotorg.org>
 <20130730204511.GX9858@sirena.org.uk> <51F8302D.406@wwwdotorg.org>
 <20130730225845.GB9858@sirena.org.uk>
 <51F98CBC.6000302@wwwdotorg.org>
Message-ID: <20130801095338.GK9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 04:16:28PM -0600, Stephen Warren wrote:
> On 07/30/2013 04:58 PM, Mark Brown wrote:

> > You seem to be assuming that the strings are a bad thing.  I'm not
> > sure that this is the case modulo the tooling issues...

> I do tend to think that using strings is pretty evil...

Well, they do avoid the legibility issues that tend to plague device
tree - I don't really mind if they're in the property names (as with
regulator supply properties) or in the data but having something that is
directly legible is a substantial win.  Constants deal with this in the
source but they make runtime debugging more painful which isn't ideal.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130801/2aa3d0b4/attachment.sig>
