From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 13:46:13 +0100
Subject: [PATCH v12 2/2] ASoC: rockchip: Use bus_type to distinguish
 rt5514 dsp from rt5514 codec
In-Reply-To: <20170919025439.7107-2-jeffy.chen@rock-chips.com>
References: <20170919025439.7107-1-jeffy.chen@rock-chips.com>
 <20170919025439.7107-2-jeffy.chen@rock-chips.com>
Message-ID: <20170919124613.egvojfhq74vhyvuh@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 10:54:39AM +0800, Jeffy Chen wrote:
> Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
> Use bus_type to distinguish rt5514 dsp from rt5514 codec.

This doens't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/d78ab1f9/attachment.sig>
