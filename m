From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 8 May 2014 09:41:57 -0700
Subject: [PATCH 00/22] Random ARM randconfig fixes in drivers
In-Reply-To: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
Message-ID: <20140508164157.GA22224@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:46:51PM +0200, Arnd Bergmann wrote:
> These are a bunch of fixes I had to do to get all randconfig
> configurations on ARM working. Most of these are really old
> bugs, but there are also some new ones. I don't think any of
> them require a backport to linux-stable.
> 
> I have checked that they are all still required on yesterday's
> linux-next kernel. Please apply on the appropriate trees unless
> there are objections.
> 
Is this series of patches also going to fix arm:allmodconfig ?

Thanks,
Guenter
