From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jan 2015 14:13:05 +0100
Subject: Unregisrtering a platform driver from another platform driver.
In-Reply-To: <CAAVaN8weDZPS5RHCuH3TYuZiQ1NUvgoUxmD00GWxqWBtUAm-jA@mail.gmail.com>
References: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
 <2724993.T8ceeSDQyL@wuerfel>
 <CAAVaN8weDZPS5RHCuH3TYuZiQ1NUvgoUxmD00GWxqWBtUAm-jA@mail.gmail.com>
Message-ID: <2368158.OB3Lz0dPss@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 12:10:45 Andy Ng wrote:
> Thank you for your reply.
> It is during the kernel boot phase, and I just want to remove it with
> unregister mechanism.
> 

I don't think there is a way to solve your problem then.

	Arnd
