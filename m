From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 18 Jun 2016 14:33:22 +0300
Subject: [PATCH v5] phy-sun4i-usb: Fix irq free conditions to match
 request conditions
In-Reply-To: <1466242293-22393-1-git-send-email-hdegoede@redhat.com>
References: <1466242293-22393-1-git-send-email-hdegoede@redhat.com>
Message-ID: <720c35c7-eb9a-2881-cb95-39fa6aa61dee@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/18/2016 12:31 PM, Hans de Goede wrote:

> commit 5cf700ac9d50("phy: phy-sun4i-usb: Fix optional gpios failing probe")
> changed the condition under which irqs are requested, but omitted matching
> changes to sun4i_usb_phy_remove(). This commit fixes this.
>
> Fixes: commit 5cf700ac9d50("phy: phy-sun4i-usb: Fix optional gpios failing probe")

    "Commit" not needed here, this tag has a standardized format.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
[...]

MBR, Sergei
