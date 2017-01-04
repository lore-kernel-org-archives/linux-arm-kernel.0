From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jan 2017 16:36:00 +0100
Subject: [GIT PULL] firmware: SCPI: fixes for v4.10
In-Reply-To: <11909baf-8ab3-7e53-ef22-2988571392f5@arm.com>
References: <11909baf-8ab3-7e53-ef22-2988571392f5@arm.com>
Message-ID: <4050603.KPQtj9REAp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 3, 2017 10:28:00 AM CET Sudeep Holla wrote:
> SCPI fix for v4.10
> 
> A simple fix for reading only lower 32-bit sensor values on pre-1.0 SCPI
> firmwares so that upper 32-bit (garbage) value is discarded properly.
> 
> 

Pulled into fixes, thanks!

	Arnd
