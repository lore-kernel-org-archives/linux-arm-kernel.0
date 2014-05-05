From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 May 2014 22:40:33 -0700
Subject: [GIT PULL] ARM: mvebu: pci/mbus fixes for v3.15
In-Reply-To: <20140429131101.GI28159@titan.lakedaemon.net>
References: <20140429131101.GI28159@titan.lakedaemon.net>
Message-ID: <20140505054033.GD16022@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 09:11:01AM -0400, Jason Cooper wrote:
> arm-soc guys,
> 
> This rather large (for fixes) changeset resolves multiple problems with
> the mvebu PCIe driver.  While it works fine for simple use cases, more
> complicated uses highlighted multiple problems with MSI handling and mbus
> window creation.
> 
> These changes are Acked by the appropriate maintainers and have been in
> -next for about a week.

Merged all three. We usually don't split up fixes in separate branches, so no
need to do so in the future.


-Olof
