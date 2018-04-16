From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Apr 2018 15:17:34 -0700
Subject: [PATCH 4/4] ARM: brcmstb: Add support for the V7 memory map
In-Reply-To: <20180223210923.544-5-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
 <20180223210923.544-5-f.fainelli@gmail.com>
Message-ID: <20180416221734.31965-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Feb 2018 13:09:23 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The 7278 device is the first device that includes support for the V7
> memory map developed for use in 64-bit architecture brcmstb devices.
> This map relocates the register physical offset from 0xF0000000 to
> 0x0000000008000000.
> 
> Since the ARM PERIPHBASE value is also relocated in the V7 memory map
> we can use its value to determine whether this device uses the new
> V7 memory map and therefore where to look for the SUN_TOP_CTRL
> register used to identify the chip family.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
