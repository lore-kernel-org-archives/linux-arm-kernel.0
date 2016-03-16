From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2016 14:57:21 +0300
Subject: [PATCH 5/5] usb: musb-da8xx: remove board-specific clock handling
In-Reply-To: <1458081473-8223-5-git-send-email-david@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-5-git-send-email-david@lechnology.com>
Message-ID: <56E94A21.7040601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/16/2016 1:37 AM, David Lechner wrote:

> This driver should not have to worry about how the clocks are configured
> on a system. Added a usb20_phy clock to handle the USB 2.0 PLL clock
> externally.
>
> Also changed to using devm_ to simplify code a bit.

    This should preferably be split to another patch. Doing one thing per 
patch is a rule of thumb.

> Signed-off-by: David Lechner <david@lechnology.com>
[...]

MBR, Sergei
