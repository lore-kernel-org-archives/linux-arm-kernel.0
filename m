From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jul 2013 16:49:27 +0100
Subject: SPI: DUAL/QUAD support
In-Reply-To: <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
Message-ID: <20130704154927.GE27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 04:58:52PM +0200, Thomas.Betker at rohde-schwarz.com wrote:

> This situation is certainly a bit special. To me, the patch looks like a 
> short-time workaround; I would rather see the flash driver support actual 
> dual or quad mode commands. Is there any work in progress?

Well, there's two bits here.  One is the support in the client drivers
for using the extra data lines and the other is the support in the SPI
core for telling controllers to do this.  We need that second bit in
place before the first one can be implemented.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130704/5c865c14/attachment.sig>
