From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 12:41:25 +0200
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes and
 cleanup
In-Reply-To: <51CC80E4.8060801@redhat.com>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com> <20130627094307.GC8437@lukather>
 <51CC0BC3.5090309@redhat.com> <20130627165436.GB4319@lukather>
 <51CC80E4.8060801@redhat.com>
Message-ID: <20130628104125.GG4319@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Thu, Jun 27, 2013 at 08:13:56PM +0200, Hans de Goede wrote:
> >Siarhei however notes that even higher-end SoCs like the exynos5 have
> >similar performances with that regard. So I'm not sure we can do
> >something about it, except what is suggested in the above mail, which
> >looks rather unsafe.
> >
> >Anyway, like you said, we have no easy other solution, and we lacked
> >such support until now.
> >
> >So why not merge this code for now, and try to optimise it later if we
> >find it's needed.
> 
> That is fine with me, I just wanted to share that this has shown as
> a bottleneck in some benchmarks in case anyone has a clever idea to
> fix it ...

And you were right, since I wasn't aware of such discussion.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/57aa2e25/attachment.sig>
