From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:06:13 -0800
Subject: [PATCH v2 02/21] ARM: tegra: clock: Don't BUG on changing an
	enabled PLL
In-Reply-To: <1298154371-5641-4-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-4-git-send-email-ccross@android.com>
Message-ID: <AANLkTimk5boeykToWCrosa5Q+Di5_uiOEU8tqh-aa0SE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> Signed-off-by: Colin Cross <ccross@android.com>

Please add a 1-line description of why bugging doesn't make sense.

Patch itself:

Acked-by: Olof Johansson <olof@lixom.net>
