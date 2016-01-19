From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 19 Jan 2016 22:50:35 +0100
Subject: [PATCH 0/2] Add support for wireless on Radxa Rock2
In-Reply-To: <1452344058-27434-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1452344058-27434-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <2280130.ybTTBxI3rJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 9. Januar 2016, 13:54:16 schrieb Sjoerd Simons:
> First patch improved the modelling of the power supplies on the Rock2
> some a bit and adds the iodomain setup needed for wireless to work.
> Second patch adds the actual updates for the wireless setup on the rock2
> square board.
> 
> With current kernels the probing of the wifi card is unfortunately not
> reliable as the 32k clock is provided by the external RTC module, this
> is fixed by a patch from Heiko still in RFC state[0] to properly defer
> things as needed. Also things only work if the io domains get
> initialized before the sdio bus is probed as their is no explicit
> dependency, fixing that is for a later patchset.

applied both to my dts32 branch for 4.6


Thaks
Heiko
