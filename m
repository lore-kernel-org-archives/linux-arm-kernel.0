From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Jul 2016 09:54:36 +0100
Subject: [PATCH 1/3] ARM: dts: imx6sx-sabreauto: Fix misspelled property
In-Reply-To: <1467691450-22975-2-git-send-email-afaerber@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-2-git-send-email-afaerber@suse.de>
Message-ID: <577B75CC.9040304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/07/16 05:04, Andreas F?rber wrote:
> In commit 99fc5ba0bfb6 ("ARM: dts: imx6sx: add i.mx6sx sabreauto board
> support") it should've been enable-sdio-wakeup (not -wakup). But that is
> now considered a legacy name for wakeup-source, so directly use the new
> name instead, as done in commit 26cefdd15db1 for the other occurrence.
>
> Fixes: 26cefdd15db1 ("ARM: dts: imx: replace legacy wakeup property with 'wakeup-source'")
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Ah, I failed to find this occurrence with grep. Thanks for fixing it.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
