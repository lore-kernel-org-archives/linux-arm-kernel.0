From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 21:19:23 +0200
Subject: [PATCH v7 0/4] Support for Generic PCI Host Controller
In-Reply-To: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
Message-ID: <201405232119.23891.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Will Deacon wrote:
>   - Removed redundant MIGHT_HAVE_PCI selections from multiplatform-enabled
>     SoCs
> 
>   - Included patch from Srikanth for generic Configuration Space access to
>     be factored out and used by other drivers
> 
>   - Fixed minor issue in I/O port allocation (I had a >= instead of a >)
> 

It seems strange that you include the patch from Srikanth but then use
a separate copy of the same code in patch 2. Is that intentional?

	Arnd
