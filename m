From: zonque@gmail.com (Daniel Mack)
Date: Wed, 07 Aug 2013 09:43:19 +0200
Subject: [PATCH 2/2] ARM: OMAP: rx51: change musb mode to OTG
In-Reply-To: <1375808776-14975-3-git-send-email-aaro.koskinen@iki.fi>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
 <1375808776-14975-3-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <5201FA97.2060702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,

On 06.08.2013 19:06, Aaro Koskinen wrote:
> Peripheral-only mode got broken in v3.11-rc1 because of unknown reasons.

Given that you have a board that is affected, could you investigate a
little maybe? I would have done it a long time ago, but I don't have
access to such hardware unfortunately.

Not saying that your patch shouldn't go in, but at some point, we need a
sane explanation why this has happened.


Thanks,
Daniel
