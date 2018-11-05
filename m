From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 12:37:42 -0800
Subject: [PATCH] ARM: dts: NSP: Move aliases to bcm-nsp.dtsi
In-Reply-To: <20181029165524.26162-1-f.fainelli@gmail.com>
References: <20181029165524.26162-1-f.fainelli@gmail.com>
Message-ID: <20181105203742.7181-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Oct 2018 09:55:23 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> All boards replicate the aliases node, move the aliases node to
> bcm-nsp.dtsi and add all the serial and ethernet ports such that a boot
> program like u-boot can populate MAC addresses accordingly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
