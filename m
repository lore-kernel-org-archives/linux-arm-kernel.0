From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 2 Apr 2015 19:19:22 +0200
Subject: [GIT PULL 1/2] ARM: tegra: Core code changes for v4.1-rc1
In-Reply-To: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150402171920.GA2677@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 12:12:12PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.1-soc
> 
> for you to fetch changes up to 5a240eff95e89af9648551a7686b0e5a7d0231ab:
> 
>   memory: tegra: Add SWGROUP names (2015-03-30 11:47:40 +0200)

Please don't merge this just yet. Mark Brown reported that this causes
build failures in linux-next and I'm working on a couple of patches to
fix this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/f49a1d63/attachment.sig>
