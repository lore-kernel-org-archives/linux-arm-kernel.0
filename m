From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Oct 2013 18:33:18 -0700
Subject: [PATCH 2/4] wl1251: move power GPIO handling into the driver
In-Reply-To: <20131028232624.GA950@earth.universe>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-3-git-send-email-sre@debian.org>
 <1382891056.102746625@f315.i.mail.ru>
 <20131027201218.GA4414@earth.universe>
 <CANOLnONKcC1i19ypb4rh2Rff3WsVhhuUhNvZvYwDV2-ZNtjVxQ@mail.gmail.com>
 <20131028192354.GA18208@sirena.org.uk>
 <20131028232624.GA950@earth.universe>
Message-ID: <20131029013318.GC16686@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:26:26AM +0100, Sebastian Reichel wrote:

> 1. The pin is named PMEN in the Nokia N900 schematics
> 2. PMEN is described as "Power management enable - system shutdown"
>    in a crippled datasheet of the wl1253, which I found in the internet.

> I don't think this is supposed to be handled by the regulator API.

I agree, this sounds like a GPIO that the driver should be understanding
directly to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/76ca3c0e/attachment.sig>
