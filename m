From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Dec 2014 23:41:33 +0000
Subject: Patch 8190/1: introduce is_device_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1412031700240.30971@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1412031700240.30971@kaball.uk.xensource.com>
Message-ID: <20141203234133.GK11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 05:07:06PM +0000, Stefano Stabellini wrote:
> Hello Russell,
> thanks for taking the patch.
> However I was thinking that it might be easier to send it as part of my
> pull request to make sure to avoid build issues (I have follow-up
> patches that call is_device_dma_coherent).
> Otherwise if you prefer to handle the patch, I'll remove it from my
> for-linus branch and I'll make sure to send out the pull request to
> Linus after yours. I would rather not rebase on your branch because
> rebasing has proven to be unpopular in the past.

If you have patches which depend on this one, it probably makes sense for
it to go through your tree instead, in which case I should drop this patch
from my tree.  I'll do that tomorrow (provided I remember.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
