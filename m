From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jan 2018 11:32:38 +0000
Subject: [PATCH] sound/tlv320dac33: Add device tree support
In-Reply-To: <20180130085314.GA4585@amd>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
Message-ID: <20180130113238.GA10525@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 09:53:14AM +0100, Pavel Machek wrote:

> Well, notice I'm converting existing driver to device tree. And that
> one already has GPIO dependency. It is possible that more work needs
> to be done there, but that should not be a reason to delay this. Feel
> free to help.

No, it's a very good reason to delay merging something.  A DT binding is
an ABI so we need to sort out interface issues and describe things as
well as we can, with board files it's not an ABI so we can just do any
old thing that happens to work and while it might not be ideal it
doesn't really matter since we can change it later if we need to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/44c7a5d7/attachment.sig>
