From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 18:46:51 +0200
Subject: [PATCH 1/7] irqchip: atmel-aic5: Add sama5d4 support
In-Reply-To: <20140911162727.GA3131@piout.net>
References: <1410450852-1834-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410450852-1834-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20140911182411.0366ad98@free-electrons.com>
 <20140911162727.GA3131@piout.net>
Message-ID: <20140911184651.7d81c238@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Thu, 11 Sep 2014 18:27:27 +0200, Alexandre Belloni wrote:
> > Sorry for the nitpick, but this seems to lack an updated to the DT
> > binding documentation, to add the new compatible string.
> > 
> 
> The Atmel SoC compatibles are not actually documented anywhere, yet...

Sorry, I pointed the wrong piece of code. I should have pointed out:

IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
