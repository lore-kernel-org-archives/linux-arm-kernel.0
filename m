From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 07 May 2014 20:26:39 +0400
Subject: [PATCH 5/7] usb: ohci-platform: Enable optional use of reset
 controller
In-Reply-To: <1399434623-20383-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <536A5EBF.10309@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-05-2014 7:50, Maxime Ripard wrote:

> The OHCI controllers used in the Allwinner A31 are asserted in reset using a

    s/asserted/powered up/?

> global reset controller.

> Add optional support for such a controller in the OHCI platform driver.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/usb/usb-ohci.txt |  1 +
>   drivers/usb/host/ohci-platform.c                   | 25 +++++++++++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)

WBR, Sergei
