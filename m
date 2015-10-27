From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 27 Oct 2015 23:53:04 +0100
Subject: [PATCH 03/19] rtc: opal: enable support for the stardard
 "wakeup-source" property
In-Reply-To: <1445422216-29375-4-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <20151027225304.GI22331@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/2015 at 11:10:00 +0100, Sudeep Holla wrote :
> Though the opal rtc driver should and will continue to support the legacy
> "has-tpo" property to enable RTC as the wakeup source, we need to add
> support for the new standard property "wakeup-source"
> 
> This patch adds support for "wakeup-source" property in addition to the
> existing "has-tpo" property.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux at googlegroups.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/rtc/rtc-opal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
