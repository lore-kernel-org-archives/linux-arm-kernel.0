From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 00:17:01 +0200
Subject: [GIT PULL] at91: soc for 3.18 #2
In-Reply-To: <1411391733-28891-1-git-send-email-nicolas.ferre@atmel.com>
References: <1411391733-28891-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201409260017.01469.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the second SoC pull-request for AT91 and it's dedicated to the addition
> of our new SAMA5D4: C-A5+neon+L2CC+vdec (in sort). The AT91 SoC support is now
> pretty simple in relation with the enhancements done recently.
> The patches go on top of the previous tag at91-soc and has no dependency.
> 
> The merge with other AT91 branches can lead to little conflicts that I resolved
> for you in the at91-3.18-resolved2 branch that you can take as an example.
> 
> Thanks, best regards,
> 
> The following changes since commit 5db722eeba0051c68e638114f6720e715b03cd2c:
> 
>   ARM: at91: Remove the support for the RSI EWS board (2014-09-19 13:13:23 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-soc2
> 
> for you to fetch changes up to 02037a9719fa89b7e5dc25cb22afc06c4eae406e:
> 
>   ARM: at91: document Atmel SMART compatibles (2014-09-22 14:42:40 +0200)
> 
> ----------------------------------------------------------------
> Second SoC batch for 3.18:
> - introduction of the new SAMA5D4 SoC and associated Evaluation Kit
> - low level soc detection and early printk code
> - taking advantage of this, documentation of all AT91 SoC DT strings

Pulled into next/soc, thanks!

	Arnd
