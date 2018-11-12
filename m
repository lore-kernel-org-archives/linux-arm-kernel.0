From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Nov 2018 12:41:14 -0800
Subject: [PATCH] ARM: BCM63XX: Enable reset controller support
In-Reply-To: <20181105230920.26270-1-f.fainelli@gmail.com>
References: <20181105230920.26270-1-f.fainelli@gmail.com>
Message-ID: <20181112204114.4928-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Nov 2018 15:09:19 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Allow BCM63xx to compile support for reset controllers since we will
> require a specific reset controller to release resets for on-chip
> peripherals.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
