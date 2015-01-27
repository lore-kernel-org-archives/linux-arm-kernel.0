From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Jan 2015 15:06:08 -0800
Subject: [RESEND PATCH v7 1/5] Documentation: DT: Add bindings for FSL
 NS16550A UART
In-Reply-To: <1422133973-16460-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1422133973-16460-1-git-send-email-bhupesh.sharma@freescale.com>
 <1422133973-16460-2-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <20150127230608.GE11789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 02:42:49AM +0530, Bhupesh Sharma wrote:
> This patch addss the device-tree documentation for Freescale's
> NS16550 UART (also called DUART).
> 
> There is a specific errata fix required in FSL NS16550 UART
> which ensures that an random interrupt storm is not observed when
> a break is provided as an input to the UART.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>


Applied.


-Olof
