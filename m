From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 18:12:11 +0000
Subject: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201302121812.11566.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> This series of patches introduces PCIe support for the Marvell Armada
> 370 and Armada XP.
> 
> This PATCHv3 follows:
>  * PATCHv2, sent on January, 28th 2013
>  * RFCv1, sent on December, 7th 2012
> 
> Thanks to all the people who discussed on the previous version of the
> patch set. The discussions have been long and complicated, but
> certainly very useful.
> 
> In order to make progress on this, and help reducing the size of the
> patch set, I would ask if it would be possible to merge patches 1 to
> 17 from the series for 3.9 (only preparation work), keeping the rest
> for 3.10. The patches in question are PCI-related, ARM-related, and
> mvebu/orion-related.

You can add my 'Reviewed-by' tag on all paches except 5, 6, and 24.

I'm fine with adding the other ones to 3.9, as well as adding
the binding document if you split that out from patch 24. Sorry for
making this so hard for you.

	Arnd
