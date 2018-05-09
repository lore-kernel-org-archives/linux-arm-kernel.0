From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 9 May 2018 09:07:40 +0200
Subject: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
In-Reply-To: <7491f58f-d24d-8f7c-c195-87d13457fd80@gmail.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180508131914.6sy7cd6urnfg3tam@flea>
 <7491f58f-d24d-8f7c-c195-87d13457fd80@gmail.com>
Message-ID: <20180509070740.x4nl7efu4ptw6c4d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, May 08, 2018 at 10:11:07AM -0700, Florian Fainelli wrote:
> On 05/08/2018 06:19 AM, Maxime Ripard wrote:
> > Hi,
> > 
> > On Fri, May 04, 2018 at 09:05:33PM +0200, Myl?ne Josserand wrote:
> >> Hello everyone,
> >>
> >> This is a V9 of my series that adds SMP support for Allwinner sun8i-a83t.
> >> Based on sunxi's tree, sunxi/for-next branch.
> >> Depends on a patch from Doug Berger that allows to include the "cpu-type"
> >> header on assembly files that I included in my series (patch 01).
> > 
> > I applied the patches, with the remarks done by Russell on v8 fixed,
> > and the function sun8i_a83t_cntvoff_init made static.
> 
> Did you push those patches to sunxi/linux.git yet? I would like to make
> sure I have the same copy of patch 1 since that is necessary for some of
> our Broadcom ARM SoCs for 4.18.

I forgot, I just did. I tested to merge the latest next tag though,
and it went fine without any conflicts, so I guess we're fine?

Maxime


-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/3ef6b223/attachment.sig>
