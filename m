From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 13:01:23 -0700
Subject: [PATCH v3 07/10] regmap: add SPMI support
In-Reply-To: <cc2f82e353885734fe61bb8d8ec8c9f7b35e0d5a.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <cc2f82e353885734fe61bb8d8ec8c9f7b35e0d5a.1382985169.git.joshc@codeaurora.org>
Message-ID: <20131028200123.GA20439@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 01:12:35PM -0500, Josh Cartwright wrote:
> Add basic support for the System Power Management Interface (SPMI) bus.
> This is a simple implementation which only implements register accesses
> via the Extended Register Read/Write Long commands.

This looks good - I've applied it on the assumption that the underlying
interfaces won't change and the suspicion that it'll be after the merge
window before users get merged.  However I did provide a tag at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/spmi

which I'm happy to see pulled into any tree that requires it.  I can
drop the patch for now if there would be a problem with getting it in
during the merge window.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/70fffb8a/attachment.sig>
