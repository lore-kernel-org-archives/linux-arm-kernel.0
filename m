From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 21:25:43 -0800
Subject: [PATCH 1/7] ARM: tegra: clock: Refcount periph clock enables
In-Reply-To: <1298342392-21236-2-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-2-git-send-email-ccross@android.com>
Message-ID: <AANLkTi=ZxE7TZWaiacLVTY_rEk8OxaEwHTTquZtc_9M+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 6:39 PM, Colin Cross <ccross@android.com> wrote:
> Some peripheral clocks share enable bits. ?Refcount the enables so
> that calling clk_disable on one clock will not turn off another
> clock.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
