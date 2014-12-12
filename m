From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Fri, 12 Dec 2014 15:55:04 +0200
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <548A0125.6040708@linutronix.de>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de> <547C3A95.30605@ti.com>
 <547C3C19.5090501@linutronix.de> <547C42FF.5010700@ti.com>
 <CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
 <548A0125.6040708@linutronix.de>
Message-ID: <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have tried your patches by cloning [1] and copying the
relevant files over the kernel I've cloned from [2].
It compiles & runs, but I'm seeing lots of pen-down/pen-up
events when I'm not touching the screen.
Any suggestions?

Hardware: Beaglebone Black with BB-View 4.3 Cape from Farnell

[1] git clone -b tsc-devel git://git.ti.com/kernel/tsc-adc.git
(tsc-devel branch)
[2] https://github.com/beagleboard/linux/tree/3.14
