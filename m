From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 11:00:31 +0530
Subject: [PATCH] ARM: dts: da850: enable the memctrl and mstpri nodes per
 board
In-Reply-To: <1479979884-9624-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479979884-9624-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <990e2373-bebd-e462-99ba-5bb4591d2644@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2016 03:01 PM, Bartosz Golaszewski wrote:
> Currently the memory controller and master priorities drivers are
> enabled in da850.dtsi. For boards for which there are no settings
> defined, this makes these drivers emit error messages.
> 
> Disable the nodes in da850.dtsi and only enable them for da850-lcdk -
> the only board that currently needs them.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to v4.10/dt

Thanks,
Sekhar
