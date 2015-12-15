From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 14 Dec 2015 17:03:12 -0800
Subject: [GIT PULL] Allwinner fixes for 4.4
In-Reply-To: <20151214120607.GA21693@lukather> (Maxime Ripard's message of
 "Mon, 14 Dec 2015 13:06:07 +0100")
References: <20151214120607.GA21693@lukather>
Message-ID: <7h8u4wbk1b.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Hi,
>
> Here a couple of fixes for the 4.4 merge window.
>
> Thanks!
> Maxime
>
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
>
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.4
>
> for you to fetch changes up to 43675ffafd3c3373f82691f539df3dc7403877fe:
>
>   bus: sunxi-rsb: unlock on error in sunxi_rsb_read() (2015-11-17 09:40:49 +0100)
>
> ----------------------------------------------------------------
> Allwinner fixes for 4.4
>
> Two patches, one to fix the touchscreen axis on one Allwinner board, and
> the other one fixing a mutex unlocking issue on one error path in the RSB
> driver.
>
> ----------------------------------------------------------------

Applied to arm-soc/fixes.

Note this just missed our latest fixes pull request to Linus for v4.4,
so this will make it into the next round.

Thanks,

Kevin
