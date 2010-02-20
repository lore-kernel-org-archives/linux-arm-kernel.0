From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Feb 2010 15:51:50 +0000
Subject: [PATCH  0/3] MXC PCMCIA Support
In-Reply-To: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
References: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
Message-ID: <20100220155150.GA3591@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2010 at 04:32:01PM +0100, Martin Fuzzey wrote:
> This patch series adds support for the MXC PCMCIA / CF controller.
> 
> It has been tested on MX21 (with CF card + ide-cs as well as a
> broadcom based wificard using b43 driver)
> 
> It has been compile only tested for MX27, MX31 as I don't have
> this hardware but the code is based on Freescale's MX31.
> 
> Changes since RFC:
>    * Split arch specifc changes from driver
>    * Update to 2.6.33-rc8 [soc-common is now a standalone module]

I do wonder whether, as you have windows, you should be using the soc
support - the soc support is based interfacing hardware which does not
have windows into the generic infrastructure which assumes the presence
of windows.
