From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Jun 2013 11:27:02 +0200
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes and
 cleanup
In-Reply-To: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51CC0566.8010302@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/26/2013 11:16 PM, Maxime Ripard wrote:
> Hi everyone,
>

<snip>

> It also finally adds a clocksource from the free running counter found in the
> A10/A13 SoCs.

Hmm, have you benchmarked this? There have been reports from linux-sunxi kernel
users (xbmc project) that the waiting for the latch is quite slow. Note we
don't have anything better yet in the linux-sunxi kernel.

Regards,

Hans
