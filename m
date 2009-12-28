From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 21:35:22 +0800
Subject: [PATCH 1/4] pxa/zeus: Allow usage of 8250-compatible UART in
	uncompress
In-Reply-To: <1261859150-17335-2-git-send-email-maz@misterjones.org>
References: <1261859150-17335-1-git-send-email-maz@misterjones.org>
	<1261859150-17335-2-git-send-email-maz@misterjones.org>
Message-ID: <f17812d70912280535w5de1aafdk9979e7d1531b5418@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2009 at 4:25 AM, Marc Zyngier <maz@misterjones.org> wrote:
> Zeus console port is wired to a 8250-compatible device
> (pxa UARTs are reserved to other uses). This patch
> allows such a configuration in the uncompress sequence.
>
> It has been regression-tested on a Viper using FFUART.
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>

Not sure if we can do this a little bit cleaner, allow me to think for
a while.
