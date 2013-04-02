From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Apr 2013 13:33:37 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SoC 64-bit DT support
In-Reply-To: <20130329074917.15695.92956.sendpatchset@w520>
References: <20130329074917.15695.92956.sendpatchset@w520>
Message-ID: <20130402043337.GD1696@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 04:49:17PM +0900, Magnus Damm wrote:
> From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> 
> The r8a7790 SoC supports LPAE and has memory window up to
> 0x2ffffffff. Convert to 64-bit addresses by enlarging
> #addr-cells and #size-cells to 2.
> 
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, queued up for v3.10 in the soc branch.
