From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Feb 2013 10:47:01 +0000
Subject: [PATCH 0/4] time: dynamic irq affinity
In-Reply-To: <512DA0EB.5000803@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
 <512DA0EB.5000803@ti.com>
Message-ID: <20130227104701.GZ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 11:30:11AM +0530, Santosh Shilimkar wrote:
> P.S: Time and again it proves that making the local timer wakeup
> capable solves the issue.

Slightly different take: it proves that hardware people don't talk to
software people about what they require to make an operating system
work.  Hardware people think they understand that and go off and do
their own thing, and expect software people to sort out their mess.

This happens all the time; there is no solution for it as long as
companies view the creation of hardware as being entirely separate
from software.
