From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 19:38:04 +0000
Subject: [PATCH] arm64: cmpxchg: update macros to prevent warnings
In-Reply-To: <20131204192938.GF14145@mudshark.cambridge.arm.com>
References: <1386098127-29070-1-git-send-email-broonie@kernel.org>
 <20131204192938.GF14145@mudshark.cambridge.arm.com>
Message-ID: <20131204193804.GE29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 07:29:38PM +0000, Will Deacon wrote:

> This removes barrier semantics from cmpxchg and makes cmpxchg_local refer to
> something which isn't defined anywhere, so the kernel doesn't even build.

Yes, see the followup I sent to this last night (and the fixed version)
- I forgot to do the git add before I did the commit --amend to fix
them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/bfd6b67a/attachment-0001.sig>
