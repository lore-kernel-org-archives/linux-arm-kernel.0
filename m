From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Jan 2013 09:24:05 +0100
Subject: [PATCH v4 01/19] irqchip: add basic infrastructure
In-Reply-To: <50E61B53.7080404@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-2-git-send-email-robherring2@gmail.com>
 <201301032136.51302.arnd@arndb.de> <50E61B53.7080404@gmail.com>
Message-ID: <20130104092405.4fb5b4f8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Thu, 03 Jan 2013 17:59:15 -0600, Rob Herring wrote:

> The timers are going down the same route, so we should agree on the
> direction. I was concerned too that it is a little too much magic, but
> it is a bit cleaner and should have fewer merge conflicts.

Indeed. Before doing the section magic thing, there were explicit
calls, and it was causing conflicts every time I was rebasing the patch
series to shuffle things around.

There are already gazillions of magic ELF sections being used all over
the place, so I'd say this mechanism is no longer magic for most of the
kernel people nowadays.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
