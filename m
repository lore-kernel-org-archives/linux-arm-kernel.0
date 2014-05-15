From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 May 2014 10:09:52 +0100
Subject: [PATCH v2 2/5] arm64: Support reboot through watchdog subsystem
In-Reply-To: <53741A5A.7070503@roeck-us.net>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
 <1399681883-891-3-git-send-email-linux@roeck-us.net>
 <53741A5A.7070503@roeck-us.net>
Message-ID: <20140515090952.GC27594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 02:37:30AM +0100, Guenter Roeck wrote:
> On 05/09/2014 05:31 PM, Guenter Roeck wrote:
> > The watchdog subsystem provides an API to perform a system reboot.
> > Use it.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Any comments / Ack from the arm maintainers ?

I'm fine with the arm/arm64 changes, but I still reckon the parameters
should be dropped unless you have a use for them.

Will
