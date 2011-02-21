From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:11:24 -0800
Subject: [PATCH v2 10/21] ARM: tegra: clock: Convert global lock to a lock
	per clock
In-Reply-To: <1298154371-5641-12-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-12-git-send-email-ccross@android.com>
Message-ID: <AANLkTi=reG4MDr3t7oc5yaGzVkJoeZLnrLKfHOgZmPLn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> Give each clock its own lock, and remove all lock traversals from
> parent to child clocks to prevent AB-BA deadlocks.
>
> This brings the locking in line with the common struct clk
> patches and should make conversion simple.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
