From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Feb 2010 22:57:47 +0000
Subject: [PATCH] Documentation: remove obsolete arm/Sharp-LH/LPD7A400 file
In-Reply-To: <201002181547.41043.bzolnier@gmail.com>
References: <201002181547.41043.bzolnier@gmail.com>
Message-ID: <20100221225747.GA5856@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 03:47:40PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> It has been obsoleted by Documentation/arm/Sharp-LH/LPD7A40X
> and can be safely removed.

Is anyone actually using any of the Sharp LH code?  Should the entire
lot be removed from the kernel?

AFAIK it's completely unmaintained and hasn't received any meaningful
updates for almost four years now, apart from random untested fixes to
make it cope with changes which have impacted it.

If no one's actually using it, it's nothing more than a maintainence
burden.
