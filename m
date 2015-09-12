From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Sep 2015 15:43:09 +0200
Subject: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
In-Reply-To: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
 (Jarkko Nikula's message of "Mon, 7 Sep 2015 10:23:01 +0300")
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
Message-ID: <87zj0rsqhe.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:

> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
> build error here because it removed the type LPSS_SSP and I didn't notice
> the type was used here too.
>
> I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
> accidentally by copying all enum pxa_ssp_type types from
> include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.
>
> Fix the build error by removing this incorrect binding.
>
> Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reported-by: Axel Lin <axel.lin@ingics.com>
> Cc: <stable@vger.kernel.org> # 4.2
> ---
> v2: Added Fixes tag suggested by Robert Jarzmik

Queued into pxa/fixes, thanks.

Cheers.

--
Robert
