From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Nov 2013 18:37:39 +0000
Subject: [PATCH 16/31] ASoC: tegra: use reset framework
In-Reply-To: <5294CCDD.30803@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
 <20131116095529.GF15393@sirena.org.uk>
 <528A4C8C.3030200@wwwdotorg.org>
 <20131118183716.GR2674@sirena.org.uk>
 <5293C787.1030005@wwwdotorg.org>
 <20131126131410.GK14725@sirena.org.uk>
 <5294CCDD.30803@wwwdotorg.org>
Message-ID: <20131126183739.GR14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 09:31:25AM -0700, Stephen Warren wrote:

> ... so, I thought you were OK with that one issue. Were there other
> issues you didn't mention before?

Probably not but I'd need to reread it, I don't think I got that much
further than noticing that there weren't any clock changes (the fact
that the clock dependency was getting added in a DMA series set off
alarm bells).  To be honest given the number of revisions that seem to
be required I'd been expecting to see a respin of the series, the ASoC
generic DMA changes did need a respin before they can be merged and I do
want to get them into the ASoC tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/be688e10/attachment.sig>
