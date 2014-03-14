From: mporter@linaro.org (Matt Porter)
Date: Fri, 14 Mar 2014 12:51:33 -0400
Subject: [PATCH 2/6] ARM: restrict BCM_KONA_UART to ARCH_BCM_MOBILE
In-Reply-To: <1394127959-3159-3-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
 <1394127959-3159-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <20140314165133.GB25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 09:45:55AM -0800, Florian Fainelli wrote:
> Low-level debugging using the Broadcom Kona UART only makes sense on the
> ARCH_BCM_MOBILE platform and would otherwise prevent ARCH_BCM_63XX from
> picking up the right UART implementation by default.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mach-bcm armsoc/for-3.15/soc-3

Thanks,
Matt
