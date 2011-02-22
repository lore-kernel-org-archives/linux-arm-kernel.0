From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 21:32:42 -0800
Subject: [PATCH 6/7] ARM: tegra: common: Enable core clocks
In-Reply-To: <1298342392-21236-7-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-7-git-send-email-ccross@android.com>
Message-ID: <AANLkTi=DpKniKVQCZTJWJ_LQHNBvfQBhaJ2AMH1+QCHE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 6:39 PM, Colin Cross <ccross@android.com> wrote:
> Enable the cpu, emc (memory controller) and csite (debug and
> trace controller) clocks during init to prevent them from
> being disabled by the bootloader clock disabling code.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
