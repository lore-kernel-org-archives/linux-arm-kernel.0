From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 11:18:18 +0200
Subject: [PATCH] arm: mvebu: update defconfig with 3.7 changes
In-Reply-To: <5087A94E.4000706@free-electrons.com>
References: <1350980269-6587-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <5087A94E.4000706@free-electrons.com>
Message-ID: <20121024091818.GA11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 10:39:42AM +0200, Gregory CLEMENT wrote:
> On 10/23/2012 10:17 AM, Thomas Petazzoni wrote:
> > The split of 370 and XP into two Kconfig options and the multiplatform
> > kernel support has changed a few Kconfig symbols, so let's update the
> > mvebu_defconfig file with the latest changes.
> 
> Indeed this patch fixes the mvebu_defconfig which was broken.
> But as now mvebu is part of multi_v7_defconfig, shouldn't we just
> removed mvebu_defconfig ?

Hi Gregory

It is probably useful for kisskb.

   Andrew
