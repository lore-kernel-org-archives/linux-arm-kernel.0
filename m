From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Aug 2017 18:11:52 +0100
Subject: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <20170817044417.22069-3-jeffy.chen@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-3-jeffy.chen@rock-chips.com>
Message-ID: <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:

> This property is no longer used.

> -Optional properties:
> -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> -  If this option is specified, which means it's required dmic need
> -  delay for DMIC to ready so that rt5514 can avoid recording before
> -  DMIC send valid data

Why would nobody ever want to use this in future?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170817/125bc7f3/attachment.sig>
