From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 7 Oct 2009 15:08:05 +0400
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <1254778533-3529-3-git-send-email-thommycheck@gmx.de>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
Message-ID: <20091007110805.GA7656@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:35 Mon 05 Oct     , Thomas Kunze wrote:
> prefix gpio definitions for direct register access with '_' so we
> can use the other names for gpio_request & co

Familiar problem - numeric vs bit-shifted gpio defines.
I'm facing it here too while converting h3[16]00 to gpiolib,
and I'm thinking about dropping bit-shifted defines completely
and using GPIO_GPIO(SOME_NUMERIC_GPIO) instead.

Perhaps you may find this idea useful for collie.

-- 
Best regards,
Dmitry "MAD" Artamonow
