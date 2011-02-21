From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:28:54 -0800
Subject: [PATCH v2 21/21] ARM: tegra: clock: Miscellaneous clock updates
In-Reply-To: <1298154371-5641-23-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-23-git-send-email-ccross@android.com>
Message-ID: <AANLkTikE8wVsuZ0QNZoB0htowSs+xeCa5+ockXH6_TgG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> Correct max rates for pclk and sclk (Originally fixed by
> ?Dima Zavin <dima@android.com>)
>
> Correct max rate for plla (Originally fixed by
> ?Stephen Warren <swarren@nvidia.com>)
>
> Remove unnecessary no-op set_rate on audio clocks
>
> Add clock lookup entries for grhost, bsea, and vde clocks
>
> Update clock clookup entries for vcp, bsea, and vde clocks
>
> Add shared clock entries for sclk and emc
>
> Add a virtual cop clock to provide a reset op (Originally fixed by
> ?Dima Zavin <dima@android.com>)
>
> Pass set_rate on super clocks through to parent
>
> Fix pllx frequency table entry for 608 MHz
>
> Remove incorrect plla frequency table entries
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
