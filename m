From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 14:59:03 -0800
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.5
In-Reply-To: <1450795558-10961-1-git-send-email-shawnguo@kernel.org>
References: <1450795558-10961-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20151222225903.GO30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:45:56PM +0800, Shawn Guo wrote:
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.5
> 
> for you to fetch changes up to f1858b0e801a45d801dc23bc1ff5be14805022c8:
> 
>   ARM: imx: select SRC for i.MX7 (2015-12-21 21:24:05 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC updates for 4.5:
> - Select HAVE_IMX_SRC for i.MX7 to avoid a randconfig build error
> - Enable cpufreq support on i.MX7D
> - A couple of random cleanup on iomux-imx31 and mach-imx6ul

Merged, thanks.


-Olof
