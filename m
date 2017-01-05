From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 16:35:56 +0100
Subject: [PATCH v2 9/9] ARM: sunxi: Convert pinctrl nodes to generic
 bindings
In-Reply-To: <58723369-50ad-1792-9be1-c277eb719044@arm.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <e32d044d2d967f24f12d83eea50e7f14f2ae1073.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67_4iriM2WS33hUWzNZY8R2WvGjqzntGBPGmNkr1Ryr_w@mail.gmail.com>
 <58723369-50ad-1792-9be1-c277eb719044@arm.com>
Message-ID: <20170105153556.pzec5jjuz7pmvsmn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 02:16:23AM +0000, Andr? Przywara wrote:
> So can I ask that we start taking this seriously and stop doing things
> which prevent Allwinner boards from being supported properly?
> Which would first involve dropping this very patch?

The driver still supports the old binding.

> Having done breakage in the past (with "allwinner,sun7i-a20-mmc", for
> instance) is no excuse for doing it again.

I'm not sure which breakage we introduced with a new compatible: the
old compatible is working just like it used to, and the new one is
working like we need it to.

> And especially I want to avoid this habit creeping into the arm64
> world (thinking about the H5 here, which may be impacted by this
> very patch, for instance).

And again, if you looked at the entire serie, you would have seen that
I took this into account.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/63b51c9d/attachment.sig>
