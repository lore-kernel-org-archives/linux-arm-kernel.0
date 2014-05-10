From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 9 May 2014 17:53:20 -0700
Subject: [PATCH v2 0/5] watchdog: Add reboot API
In-Reply-To: <536D74E3.8010609@infradead.org>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
 <536D74E3.8010609@infradead.org>
Message-ID: <20140510005320.GA1319@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 05:37:55PM -0700, Randy Dunlap wrote:
> On 05/09/2014 05:31 PM, Guenter Roeck wrote:
> > Some hardware implements reboot through its watchdog hardware, for example
> > by triggering a watchdog timeout or by writing into its watchdog register
> > set. Platform specific code starts to spread into watchdog drivers,
> > typically by setting pointers to a callback function which is then called
> > from the architecture's reset handler.
> 
> No updates to Documentation/watchdog/ ?
> 

You are absolutely right, I missed that completely.
Will follow in v3.

Thanks,
Guenter
