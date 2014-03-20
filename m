From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 20 Mar 2014 09:33:39 +0100
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <1395235406-13449-1-git-send-email-y>
References: <1395235406-13449-1-git-send-email-y>
Message-ID: <201403200933.39382.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Wednesday 19 March 2014 14:23:26 y at karo-electronics.de wrote:
> With a flash-based BBT there is no reason to move the Factory Bad
> Block Marker from the data area buffer (to where it is mapped by the
> GPMI NAND controller) to the OOB buffer. Thus, make this feature
> configurable via DT. This is required for the Ka-Ro electronics
> platforms.
> [...]

How do you create the BBT the very first time with valuable data when the NAND 
already contains factory bad blocks?

jbe

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
