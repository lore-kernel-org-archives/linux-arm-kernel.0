From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 07 Nov 2018 08:57:51 +0100
Subject: [PATCH 2/2] ARM: Kconfig: remove useless "default n"
In-Reply-To: <20181106152916.GA56134@atomide.com> (Tony Lindgren's message of
 "Tue, 6 Nov 2018 07:29:16 -0800")
References: <E1gK0nc-0007fv-En@rmk-PC.armlinux.org.uk>
 <20181106152916.GA56134@atomide.com>
Message-ID: <87zhull3pc.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King <rmk+kernel@armlinux.org.uk> [181106 12:49]:
>> The default for Kconfig options is always n, so there's no need to
>> explicitly state a "n" default.
>> 
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Acked-by: Tony Lindgren <tony@atomide.com>
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
