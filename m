From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Aug 2018 19:03:35 +0100
Subject: [PATCH v2] ASoC: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828154433.5693-2-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
 <20180828154433.5693-2-robh@kernel.org>
Message-ID: <20180828180335.GG2414@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 10:44:28AM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please don't send new patches in reply to existing threads, it makes it
harder to follow what the current versions of things are.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/5f34695f/attachment.sig>
