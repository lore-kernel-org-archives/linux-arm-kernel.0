From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 09 May 2014 17:37:55 -0700
Subject: [PATCH v2 0/5] watchdog: Add reboot API
In-Reply-To: <1399681883-891-1-git-send-email-linux@roeck-us.net>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
Message-ID: <536D74E3.8010609@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 05:31 PM, Guenter Roeck wrote:
> Some hardware implements reboot through its watchdog hardware, for example
> by triggering a watchdog timeout or by writing into its watchdog register
> set. Platform specific code starts to spread into watchdog drivers,
> typically by setting pointers to a callback function which is then called
> from the architecture's reset handler.

No updates to Documentation/watchdog/ ?

-- 
~Randy
