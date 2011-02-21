From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:12:52 -0800
Subject: [PATCH v2 11/21] ARM: tegra: cpufreq: Take an extra reference to
	pllx
In-Reply-To: <1298154371-5641-13-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-13-git-send-email-ccross@android.com>
Message-ID: <AANLkTim94eXW90gUoHWagStEPyEiVPUhZyS=1EG2qk4f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> During cpu frequency changes, take an extra reference to pllx so
> that it doesn't turn off and on while the cpu is temporarily on
> pllp. ?If the cpu is moved to pllp permanently, pllx will be
> turned off.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
