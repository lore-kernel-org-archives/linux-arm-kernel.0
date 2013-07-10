From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 22:21:04 +0900
Subject: [PATCH 3/3] ARM: shmobile: Insert align directives before 4
 bytes data
In-Reply-To: <1373421397-1786-4-git-send-email-koba@kmckk.co.jp>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
 <1373421397-1786-4-git-send-email-koba@kmckk.co.jp>
Message-ID: <20130710132104.GD13716@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 10:56:37AM +0900, Tetsuyuki Kobayashi wrote:
> In thumb2 mode instructions are not align to 4 byte. This patch insert
> align directives before putting 4 byte data.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
>  arch/arm/mach-shmobile/headsmp-scu.S  |    1 +
>  arch/arm/mach-shmobile/headsmp.S      |    1 +
>  arch/arm/mach-shmobile/sleep-sh7372.S |    2 ++
>  3 files changed, 4 insertions(+)

Thanks, I have queued this up with Magnus's ack in the thumb-fixes
branch of my renesas tree on kernel.org. It should be
included in the renesas-next-20130710v2 tag.
