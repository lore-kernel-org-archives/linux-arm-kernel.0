From: khilman@ti.com (Kevin Hilman)
Date: Tue, 12 Jul 2011 15:32:01 -0700
Subject: [PATCH] OMAP4: 4430SDP: Keypad: Make keypad_data initdata
In-Reply-To: <1310488329-16139-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Tue, 12 Jul 2011 22:02:09 +0530")
References: <1310488329-16139-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <871uxvt9jy.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The keypad data is accessed only at init so making it initdata.
> This removes the section mismatch warning.
>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, if it's not too late, this should probably queue for v3.1 so that
it goes in at the same time as the patch that introduces this compile
warning.

Kevin
