From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 17:58:20 +0200
Subject: [PATCH 2/5] power: reset: Add Allwinner A31 reset code
In-Reply-To: <1398265476-29373-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398265476-29373-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <8237209.ZduvMhRroZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 17:04:33 Maxime Ripard wrote:
> That code used to be in the machine code, but it's more fit here with other
> restart hooks.
> 
> That will allow to cleanup the machine directory, while waiting for a proper
> watchdog driver for the A31.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
