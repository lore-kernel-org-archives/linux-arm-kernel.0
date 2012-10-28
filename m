From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 27 Oct 2012 20:33:48 -0600
Subject: [PATCH] arm: bcm2835: enable proc and sysfs in defconfig
In-Reply-To: <1351357249-17658-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351357249-17658-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <508C998C.9070903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2012 11:00 AM, Thomas Petazzoni wrote:
> For some reason, support for proc and sysfs is currently disabled in
> the bcm2835_defconfig, even though those filesystems are quite
> essential even for very basic Linux userspace. As most defconfig have
> them enabled by default, enable them as well in bcm2835_defconfig.

How silly of me; I had this as part of a local change for testing, but
hadn't made a patch to add it to the defconfig upstream.

Applied to bcm2835's for-3.8/defconfig branch. Thanks.
