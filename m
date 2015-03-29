From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Mar 2015 13:56:18 -0700
Subject: [PATCH] arm64: juno: Fix misleading name of UART reference clock
In-Reply-To: <1426595741-6213-1-git-send-email-Dave.Martin@arm.com>
References: <1426595741-6213-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150329205618.GA13301@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 12:35:41PM +0000, Dave Martin wrote:
> The UART reference clock speed is 7273.8 kHz, not 72738 kHz.
> 
> Dots aren't usually used in node names even though ePAPR permits
> them.  However, this can easily be avoided by expressing the
> frequency in Hz, not kHz.
> 
> This patch changes the name to refclk7273800hz, reflecting the
> actual clock speed.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Applied.


-Olof
