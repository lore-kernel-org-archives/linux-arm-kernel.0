From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 27 Jul 2017 15:07:03 +0000 (UTC)
Subject: [PATCH] ARM: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-1-robh@kernel.org>
References: <20170718214339.7774-1-robh@kernel.org>
Message-ID: <alpine.DEB.2.02.1707271506200.23088@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jul 2017, Rob Herring wrote:

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.

Acked-by: Paul Walmsley <paul@pwsan.com>  # for mach-omap2/omap-hwmod.c

- Paul
