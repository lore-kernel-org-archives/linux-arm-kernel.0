From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:05:29 -0800
Subject: [PATCH v2 01/21] ARM: tegra: clock: enable clk reset for
	non-peripheral clocks
In-Reply-To: <1298154371-5641-3-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-3-git-send-email-ccross@android.com>
Message-ID: <AANLkTimOX62Qm4DsjjevCotj8ULrqYvSm_TuM3gpY2r=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> From: Dima Zavin <dima@android.com>
>
> Add a new 'reset' clk op. This can be provided for any clock,
> not just peripherals.
>
> Signed-off-by: Dima Zavin <dima@android.com>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
