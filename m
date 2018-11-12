From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Nov 2018 10:27:30 -0800
Subject: [GIT PULL] arm64: dts: TI AM65x fixes for 4.20
In-Reply-To: <1f8d9384-f002-d4a1-bd63-bb2ece27d922@ti.com>
References: <1f8d9384-f002-d4a1-bd63-bb2ece27d922@ti.com>
Message-ID: <20181112182730.y56gmdgzrrcgpyos@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 06:42:21PM +0200, Tero Kristo wrote:
> Hi ARM-SoC team,
> 
> One simple fix for TI AM65x DTS towards 4.20.
> 
> -Tero
> 
> ---
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux
> tags/am654-fixes-for-v4.20
> 
> for you to fetch changes up to 8588eac3ff66e77fb681591714fd76da3a4da80d:
> 
>   arm64: dts: ti: k3-am654: Fix wakeup_uart reg address (2018-11-09 18:26:52
> +0200)
> 
> ----------------------------------------------------------------
> Texas Instruments AM65x fixes for v4.20
> 
> - Fix the wkup uart instance addresses to use proper cell sizes, otherwise
>   the uart fails to probe.

Thanks, merged.


-Olof
