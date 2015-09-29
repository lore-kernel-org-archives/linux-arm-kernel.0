From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 00:01:40 +0200
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
In-Reply-To: <560AFBC2.5050000@eclis.ch>
References: <1443556987-2788-1-git-send-email-jc@eclis.ch>
 <20150929203554.GH3982@pengutronix.de> <560AFBC2.5050000@eclis.ch>
Message-ID: <20150929220140.GA3639@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29/09/2015 at 22:59:46 +0200, Jean-Christian de Rivaz wrote :
> Without the explicit disabling, the user will be asked and could possibly
> give the wrong answer as the help look as a cool feature and the condition
> is very hard to understand.
> 

That is not true, if you remove it from the defconfig, it will simply be
disabled in the final config.

Moreover, I would prefer a better commit message than "Russell said so"

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
