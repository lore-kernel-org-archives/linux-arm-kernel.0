From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 06 Jul 2011 16:11:05 +0400
Subject: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate header
In-Reply-To: <1309892440-3260-7-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-7-git-send-email-vkuzmichev@mvista.com>
Message-ID: <4E1450D9.3040601@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-07-2011 23:00, Vitaly Kuzmichev wrote:

> Signed-off-by: Vitaly Kuzmichev<vkuzmichev@mvista.com>
> ---
>   drivers/watchdog/mpcore_wdt.c |   26 +-------------------------
>   drivers/watchdog/mpcore_wdt.h |   40 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+), 25 deletions(-)
>   create mode 100644 drivers/watchdog/mpcore_wdt.h

    Are the declarations only used by mpcore_wdt.c? If so, why we need a header?

WBR, Sergei
