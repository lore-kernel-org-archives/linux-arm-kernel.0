From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 16 May 2012 20:36:20 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20403.22671.800713.334846@ipc1.ka-ro>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
Message-ID: <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2012 15:34, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> You initialize a variable to a specific value that defaulted to zero
> before.
>
The variable defaulted to zero is causing a problem.  I'm fixing that problem.

Regards,
Shawn
