From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jul 2014 11:58:55 -0600
Subject: [PATCH] MAINTAINERS: Update Tegra Git URL
In-Reply-To: <1406568643-2047-1-git-send-email-afaerber@suse.de>
References: <1406568643-2047-1-git-send-email-afaerber@suse.de>
Message-ID: <53D68F5F.6050109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2014 11:30 AM, Andreas F?rber wrote:
> swarren/linux-tegra.git does not exist, it's tegra/linux.git.

FWIW, there is a redirect in place, so "git clone" on the old URL works 
fine. Still, we should indeed update the MAINTAINERS entry to point at 
the correct location.

I'll forward this on to arm at kernel.org to be applied.
