From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Mar 2015 17:07:45 -0700
Subject: [PATCH v2 0/2] ARM: dts: sunxi: Fix cpufreq instabilities
In-Reply-To: <CAGb2v67vP-cSzOFk7s9O3b7+afa62zSpYT5asgbcvrAyfS5EPA@mail.gmail.com>
References: <1426834160-10409-1-git-send-email-wens@csie.org>
 <20150321182035.GE2774@lukather>
 <CAGb2v67vP-cSzOFk7s9O3b7+afa62zSpYT5asgbcvrAyfS5EPA@mail.gmail.com>
Message-ID: <20150324000745.GI15676@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 04:43:09PM -0700, Chen-Yu Tsai wrote:
> On Sat, Mar 21, 2015 at 11:20 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Mar 20, 2015 at 02:49:18PM +0800, Chen-Yu Tsai wrote:
> >> Hi Maxime,
> >>
> >> Here's v2 of the sunxi cpufreq dts fixes, aimed at 4.0.
> >>
> >> The first patch limits the Olimex A10-Lime to 912MHz, as a few people
> >> reported on IRC that it was unstable at 1008MHz.
> >>
> >> The second patch removes the overclocking settings from sun[457]i dts,
> >> so all the boards will be stable, regardless of whether regulators
> >> were added or not.
> >>
> >> I would like to revisit this after the new OPP bindings are merged
> >> and support added to cpufreq-dt.
> >
> > Applied both, thanks!
> 
> I see you applied them under sunxi/dt-for-4.1.
> Shouldn't we merge them for 4.0 fixes?

Your patch doesn't apply on 4.0 unfortunately.

I dropped it at the moment, would you care to resend it?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/ec649fec/attachment.sig>
