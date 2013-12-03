From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Dec 2013 19:20:26 +0000
Subject: [PATCH] arm64: cmpxchg: update macros to prevent warnings
In-Reply-To: <1386098127-29070-1-git-send-email-broonie@kernel.org>
References: <1386098127-29070-1-git-send-email-broonie@kernel.org>
Message-ID: <20131203192026.GA29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 07:15:27PM +0000, Mark Brown wrote:
> From: Mark Hambleton <mahamble@broadcom.com>
> 
> Make sure the value we are going to return is referenced in order to
> avoid warnings from newer GCCs such as:

Sorry, I was missing a commit --amend here - resent with the correction
made.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/264dc0d8/attachment-0001.sig>
