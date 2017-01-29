From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:47:31 -0800
Subject: [GIT_PULL 3/3] SOC: Keystone driver SOC for 4.11
In-Reply-To: <1485039758-15248-3-git-send-email-ssantosh@kernel.org>
References: <1485039758-15248-1-git-send-email-ssantosh@kernel.org>
 <1485039758-15248-3-git-send-email-ssantosh@kernel.org>
Message-ID: <20170129224731.GH3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2017 at 03:02:38PM -0800, Santosh Shilimkar wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_soc_for_4.11
> 
> for you to fetch changes up to 6e03f653e318ac8d248a945082174b39733489f5:
> 
>   soc: ti: knav: cleanup includes and sort header files (2017-01-06 11:05:45 -0800)
> 
> ----------------------------------------------------------------
> Couple of minor cleanups for Navigator drivers for 4.11
> 
> ----------------------------------------------------------------
> Murali Karicheri (2):
>       soc: ti: knav_dma: fix typos in trace message
>       soc: ti: knav: cleanup includes and sort header files
> 
>  drivers/soc/ti/knav_dma.c        |  4 ++--
>  drivers/soc/ti/knav_qmss_acc.c   | 15 +++------------
>  drivers/soc/ti/knav_qmss_queue.c | 25 ++++++++-----------------
>  3 files changed, 13 insertions(+), 31 deletions(-)

Merged, thanks.


-Olof
