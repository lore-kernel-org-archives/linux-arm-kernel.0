From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Sep 2017 08:58:14 +0200
Subject: [PATCH] dmaengine: sun6i: sun4i-gpadc: use
 of_device_get_match_data
In-Reply-To: <20170919184447.4479-1-clabbe.montjoie@gmail.com>
References: <20170919184447.4479-1-clabbe.montjoie@gmail.com>
Message-ID: <20170920065814.fle73gxbu3oyqsr4@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 19, 2017 at 06:44:47PM +0000, Corentin Labbe wrote:
> The usage of of_device_get_match_data reduce the code size a bit.
> Furthermore, it prevents an improbable dereference when
> of_match_device() return NULL.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

The prefix of your commit title is wrong, this isn't about the GPADC.

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170920/7ae18cac/attachment.sig>
