From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 15:25:12 -0600
Subject: [PATCHv5 4/7] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <1364970291-17721-5-git-send-email-linux@prisktech.co.nz>
References: <1364970291-17721-1-git-send-email-linux@prisktech.co.nz>
 <1364970291-17721-5-git-send-email-linux@prisktech.co.nz>
Message-ID: <515C9E38.9060603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 12:24 AM, Tony Prisk wrote:
> This patch adds support for the GPIO/pinmux controller found on the VIA
> VT8500 and Wondermedia WM8xxx-series SoCs.
> 
> Each pin within the controller is capable of operating as a GPIO or as
> an alternate function. The pins are numbered according to their control
> bank/bit so that if new pins are added, the existing numbering is maintained.
> 
> All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
> WM8850.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

At a quick glance, the alloc/free stuff looks good in this patch, so I
re-affirm the reviewed-by above.
