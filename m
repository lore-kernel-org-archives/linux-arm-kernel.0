From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 07 Dec 2012 15:40:12 +0000
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354894134.17101.44.camel@gandalf.local.home>
References: <1354817466.30905.13.camel@linaro1.home>
 <1354821581.17101.17.camel@gandalf.local.home>
 <1354872138.3176.15.camel@computer5.home>
 <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
Message-ID: <1354894812.13000.59.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 10:28 -0500, Steven Rostedt wrote:
> I'm not NACKing your previous patch, I was just suggesting to bring ARM
> up to the future :-)

ARM is the future ;-)

> 
> I have no problems with the patch, but I just want to put it out there
> that there's better ways. It's part of the remove stomp_machine()
> crusade ;-)

Indeed, when I first cam across stop_machine(), I though 'yuck!',
especially when I realised Linux scheduling seems to mean the system
goes idle until the the next tick triggers scheduling of these 'highest
priority' threads.

-- 
Tixy
