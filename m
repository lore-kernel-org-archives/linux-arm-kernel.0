From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 11 Feb 2014 09:53:15 -0800
Subject: [PATCH v2 0/2] ohci-/ehci-platform: Change compatible string to
 generic-?hci
In-Reply-To: <1392136529-5060-1-git-send-email-hdegoede@redhat.com> (Hans de
 Goede's message of "Tue, 11 Feb 2014 17:35:27 +0100")
References: <1392136529-5060-1-git-send-email-hdegoede@redhat.com>
Message-ID: <7h7g917cz8.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hans de Goede <hdegoede@redhat.com> writes:

> Hi Greg,
>
> And here is v2 of my ohci-/ehci-platform fixes for the regression of USB
> support on various ARM boards I caused in linux-next.
>
> As expected some people still did not like the ?hci-platform compatible
> string I went for in v1, hence this v2. The good news is it seems everyone
> seems to be able to live with generic-?hci as compatible now, so it seems this
> issue is finally settled.
>
> Please add these 2 patches to your usb-next tree, as said in the cover-letter
> of v1, I'm fine with you squashing these into the first 2 patches of my
> original series, but if you want them separate to preserve history that is
> fine too.

I tested this series on top of next-20140211 on the OMAP platforms where
I noticed the regressions, and confirm it fixes the problem.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
