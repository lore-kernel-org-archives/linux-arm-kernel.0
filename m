From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 14:55:18 +0200
Subject: [PATCH v2 01/10] pinctrl: move gpio-axp209 to pinctrl
In-Reply-To: <e193f8efe9092171ebeffb77ab77422179fd3cab.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <e193f8efe9092171ebeffb77ab77422179fd3cab.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170926125518.kulkohinaojty2zl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 12:17:11PM +0000, Quentin Schulz wrote:
> To prepare the driver for the upcoming pinctrl features, move the GPIO
> driver AXP209 from GPIO to pinctrl subsystem.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

I'm not sure we actually need to do this. Can't we just keep the
driver here?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/e37b8e87/attachment-0001.sig>
