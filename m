From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 16:06:00 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140321151617.GA11938@red-moon>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320180836.GA3307@red-moon>
 <20140321113202.GJ11706@sirena.org.uk>
 <20140321151617.GA11938@red-moon>
Message-ID: <20140321160600.GB552@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 03:16:17PM +0000, Lorenzo Pieralisi wrote:

> I understand that and I apologize, but I will still flag issues up
> as long as I find some. For instance, I noticed patch is missing

Thanks.  I do agree that it's important to find and fix issues, it was
more about the mechanics of how that gets done.

> Instead of bothering you with another respin with minor changes I suggest
> I will pick the last version up, diff what's needed and repost it here for
> final look so that we are done with it.

> Please let me know if that's plausible, thank you.

I've actually already got a mostly complete respin so I may as well send
that, just doing a bit of testing though I'll wrap in the of_node_put()s
as well now you mention that.  Should be out this afternoon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/23e3ff22/attachment.sig>
