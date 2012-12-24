From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 24 Dec 2012 09:40:52 -0700
Subject: [PATCH V3 00/11] ARM: delete struct sys_timer
In-Reply-To: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50D88594.6060601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 11:30 AM, Stephen Warren wrote:
> Russell, I'm mainly reposting this to see if you have any comments or
> opinion, in particular on the core ARM changes.
> 
> The aim of this series is to remove ARM's struct sys_timer. As a pre-
> cursor, this requires a little re-arrangement of arch_gettimeoffset and
> associated changes to other architectures.
> 
> The full series can be found in git at:

(now at):
git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
arm-timer-rework

I have put this branch into the Tegra tree's for-next branch. Once the
holidays are over, I'll send a pull request to get this into arm-soc as
a baseline branch for others to build on.
