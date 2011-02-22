From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 21:30:34 -0800
Subject: [PATCH 4/7] ARM: tegra: Move tegra_common_init to tegra_init_early
In-Reply-To: <1298342392-21236-5-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-5-git-send-email-ccross@android.com>
Message-ID: <AANLkTi=WF_i46ONPf9N+=qdZA0mkP4P4QQO79Amb54CD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 6:39 PM, Colin Cross <ccross@android.com> wrote:
> Move tegra_common_init to tegra_init_early, and set it
> as the init_early entry in the machine struct.
> Initializes the clocks earlier so that timers can enable
> their clocks.
>
> Also reorders the members in the Harmony and Trimslice
> boards' machine structs to match the order they are
> called in.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>

Please push this ASAP so I can rebase my series, even if some of the
others might need respin. :)


-Olof
