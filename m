From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 18 Feb 2010 14:46:15 +0800
Subject: [PATCH 2/2] arm/pxa: Let zeus.c link without CONFIG_PM enabled.
In-Reply-To: <20100216221255.0f905df3@taxman.wild-wind.fr.eu.org>
References: <1266356575-1364-1-git-send-email-stefan@datenfreihafen.org>
	<20100216221255.0f905df3@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d71002172246s4d90fd96x51dde9dd3ec8dcc9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Acked-by: Marc Zyngier <maz@misterjones.org>
>
> Eric, are you willing to take this directly, or do you want me to queue
> it for the next merge window with the rest of the fixes?
>

With your Ack, I've applied this to 'devel'. The zeus can still be
built with CONFIG_PM enabled, so I tend to include this for the
next merge window instead of going into the -rc phase.

And note this doesn't look like a final fix to this issue, so you
may want to work a bit on it some time later.

Please submit the rest of the fixes as we are close to the merge
window. And thanks.
