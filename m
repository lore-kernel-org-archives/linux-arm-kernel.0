From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 11 Jan 2014 02:50:51 +0300
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <1389393980-21183-1-git-send-email-hdegoede@redhat.com>
References: <1389393980-21183-1-git-send-email-hdegoede@redhat.com>
Message-ID: <52D0875B.9040102@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/11/2014 01:46 AM, Hans de Goede wrote:

> Here is v4 of my ohci and ehci-platform clks, phy and dt support patch-set,
> this version should be 100% ready for merging upstream.

    I see you've decided to completely ignore my opinion. NAK, FWIW.

> Changes since v3:
> -Address all of Alan Stern's review comments
> -Properly use put_clk in probe error path
> -Don't do hcd_put until after power_off as power_off may use private hcd data
> Regards,

> Hans

WBR, Sergei
