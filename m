From: slash.tmp@free.fr (Mason)
Date: Tue, 21 Jun 2016 13:02:13 +0200
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <57691EB5.5080901@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2016 21:44, Russell King wrote:

> If we want to assume that the compressed image will expand by a maximum
> of 4x, we actually need to reserve 5x the space, since we need to keep
> a copy of the compessed image around while decompressing.
                ^^^^^^^^^
compressed ;-)
