From: jslaby@suse.cz (Jiri Slaby)
Date: Fri, 29 Apr 2016 11:24:44 +0200
Subject: [PATCH] tty: serial, return values platform_get_irq, part II.
In-Reply-To: <1461921721-30169-1-git-send-email-jslaby@suse.cz>
References: <1461921721-30169-1-git-send-email-jslaby@suse.cz>
Message-ID: <5723285C.3080008@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2016, 11:22 AM, Jiri Slaby wrote:
> When commit "TTY: serial, handle platform_get_irq retval properly" was
> merged, it was pointed out, that platform_get_irq is more peculiar
> than it seems.
> 
> platform_get_irq can actually return zero for some platforms. So
> reverts parts of the aforementioned commits which did the worng thing
> on those platforms.

Given I double checked the code, I should do so for the commit message
too. Please scratch this one due to the commit message.

thanks,
-- 
js
suse labs
