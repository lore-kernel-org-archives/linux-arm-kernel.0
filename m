From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Sep 2014 11:02:53 -0400
Subject: [PATCH] Documentation: arm: add hardware datasheet reference
 for Marvell Armada XP
In-Reply-To: <1410896277-32476-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410896277-32476-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140917150253.GC16945@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, Sep 16, 2014 at 09:37:57PM +0200, Thomas Petazzoni wrote:
> Some time ago, the "Function Specifications" for the Marvell Armada XP
> processor has been released. However, the "Hardware Specifications"
> were not released at the same time. They have now been released
> publicly, so this commit updates the Marvell documentation file with
> the references to this new documentation.
> 
> Three documents are available, one for each of the three variants of
> Armada XP: 78230, 78260 and 78460.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/arm/Marvell/README | 4 ++++
>  1 file changed, 4 insertions(+)

Awesome work getting those released!

I've applied this to mvebu/dt since I'm probably only doing one more
pull request this cycle, and it's most likely /dt.

thx,

Jason.
