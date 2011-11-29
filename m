From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Nov 2011 14:51:18 +0000
Subject: [GIT PULL] DSS fixes for v3.2-rc2
In-Reply-To: <1322554347.1869.6.camel@deskari>
References: <20111123235542.GL31337@atomide.com>
 <201111241606.54879.arnd@arndb.de> <1322554347.1869.6.camel@deskari>
Message-ID: <201111291451.19081.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2011, Tomi Valkeinen wrote:
> I don't think we need these in 3.1 stable. The omapdss driver in 3.1
> contains hacks to circumvent the HWMOD issues the patches below fix.
> These hacks were removed for 3.2.
> 
> Well, the "ARM: OMAP2PLUS: DSS: Ensure DSS works correctly..." patch
> could be used for 3.1 also, but I fear it depends on HWMOD and DSS
> patches missing from 3.1. I'll check it out.

Ok, thanks for taking a look,

	Arnd
