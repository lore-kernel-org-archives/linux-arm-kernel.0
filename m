From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 14:32:11 +0000
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120312142857.GA6694@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
 <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
 <20120312142340.GI3110@opensource.wolfsonmicro.com>
 <20120312142857.GA6694@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120312143210.GJ3110@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 03:28:58PM +0100, Thierry Reding wrote:

> In that case I'll mark the *-supply properties required. Would it be a good
> idea to mention this (or even give an example with fixed regulators) in the
> binding documentation or can I assume this to be common knowledge?

Probably the best thing here is to just reference the regulator binding
documentation which mentions -supply properties (or should do) and then
clarify that if need be.  No sense in putting things like this into the
binding document for a specific driver, there's nothing driver specific.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/a5a8b0cf/attachment-0001.sig>
