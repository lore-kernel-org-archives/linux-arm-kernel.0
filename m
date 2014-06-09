From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Jun 2014 23:51:42 +0100
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <1976508.Da0u8DZI5B@vostro.rjw.lan>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <3122018.iBNBjMKNbN@vostro.rjw.lan>
 <20140609194917.GH5099@sirena.org.uk>
 <1976508.Da0u8DZI5B@vostro.rjw.lan>
Message-ID: <20140609225142.GA5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 12:22:07AM +0200, Rafael J. Wysocki wrote:
> On Monday, June 09, 2014 08:49:17 PM Mark Brown wrote:

> > Yes, looks like it is.

> But it doesn't apply for me on top of the current Linus' tree.

> Can you please rebase?

It probably depends on other people's trees too, I just killed all the
usages in -next - I gather the SH trees added some new ones for example.
I'd expect it'll apply after the merge window, if not that's the time to
look at it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140609/8e1c04eb/attachment-0001.sig>
