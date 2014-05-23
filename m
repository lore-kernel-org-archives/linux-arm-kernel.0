From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 May 2014 01:00:32 +0200
Subject: [PATCH RESEND v2 0/3] bus: add Broadcom GISB bus arbiter
 timeout/error handler
In-Reply-To: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
References: <1400529962-9612-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201405240100.32725.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 May 2014, Florian Fainelli wrote:
> Hi all,
> 
> This patch adds support for the Broadcom GISB bus arbiter timeout/error handler.
> GISB is a custom and proprietary bus used in the Broadcom Set Top Box devices
> exclusively. The bus arbiter offers the possibly to decode faulting masters as
> well as masters that are timing out on the bus.
> 
> V2 addresses some comments made by Arnd, and widens the audience by posting
> on linux-arm-kernel as well.
> 
> These patches should be merged via the 'arm-soc' tree. I am resending those
> such that every mailing-list has them in copy.
> 
> Thank you!

Applied to the next/drivers branch now. I've changed the Kconfig and Makefile
slightly to maintain alphabetical ordering, which helps avoid a merge conflict
with the vexpress drivers.

	Arnd
