From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 22:45:44 +0000
Subject: [PATCH 4/4] at91 : implement the standby function for pm/cpuidle
In-Reply-To: <4F1746DE.4000902@gmail.com>
References: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
 <1326843620-13148-5-git-send-email-daniel.lezcano@linaro.org>
 <4F1742E8.8090108@gmail.com> <20120118221845.GS1068@n2100.arm.linux.org.uk>
 <4F1746DE.4000902@gmail.com>
Message-ID: <20120118224544.GT1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 09:25:34AM +1100, Ryan Mallon wrote:
> After this patch we still have the limitation that only one at91
> platform can be built into the kernel (this is an existing problem,
> which there is an on going effort to resolve) because the at91_standby
> function is defined via ifdefs. So the at91_standby define should still
> be converted to a function pointer and assigned via the soc right? Of
> course, this can be done in a subsequent patch.

Correct; that's something I did suggest.
