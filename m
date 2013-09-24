From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Sep 2013 16:37:01 +0100
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20130924105127.GB12758@n2100.arm.linux.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20130924105127.GB12758@n2100.arm.linux.org.uk>
Message-ID: <20130924153701.GF3226@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 11:51:27AM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:
> > This patch adds S/PDIF input/output for mvebu DT boards.

> Right, so if this goes in, then we're completely fucked for doing this
> the way that Mark apparantly wants it to be done, because once these
> DT properties go in, they're there to stay.

I'm not sure that this is in particular conflict with any other way of
writing things, though it would be redundant.  The best thing would be
to key this off connecting to DAIs so that people just need to make the
connections that exist in their system in the device tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/86f8d022/attachment.sig>
