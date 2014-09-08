From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 14:57:52 +0200
Subject: [PATCH v6 0/5]  Add EHCI and OHCI drivers for STi SoC's
In-Reply-To: <1410177888-26710-1-git-send-email-peter.griffin@linaro.org>
References: <1410177888-26710-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <3096462.9jpenVzhmp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 13:04:43 Peter Griffin wrote:
> I believe all feedback has been incorporated, and this series has also been rebased on
> 3.17-rc3.
> 
> It was re-worked from v2 onwards to split out the ehci and ohci parts
> into their own drivers / devices like most other ARM platforms based on
> feedback from Arnd Bergmann (see here http://www.spinics.net/lists/linux-usb/msg111124.html. 
> 
> The ehci-platform & ohci-platform have been used as a basis for this in case we
> wish to merge the drivers again in the future.
> 

Looks good to me. Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
