From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:09:07 -0800
Subject: [PATCH v2 07/21] ARM: tegra: clock: Drop CPU dvfs
In-Reply-To: <1298154371-5641-9-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-9-git-send-email-ccross@android.com>
Message-ID: <AANLkTikTm1EKh87e274mehu+KcURCdMRN5abvHSX3qMY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> The existing version did not extend well to core dvfs, drop it
> for now until the new clk api with clk_prepare and clk_unprepare
> is ready and non-atomic clocks are possible.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
