From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Jan 2018 09:39:16 +0100
Subject: [PATCH v1 3/4] ARM: dts: add pwm pins for r40.
In-Reply-To: <CAJeuY7-FeiEtSkg=udnEx_==3SS=dinyk7fKqhLwdXcKE3510g@mail.gmail.com>
References: <20180111113323.GA21976@arx-s1>
 <20180111124701.g52kjm3hozn72je5@flea.lan>
 <CAJeuY7-FeiEtSkg=udnEx_==3SS=dinyk7fKqhLwdXcKE3510g@mail.gmail.com>
Message-ID: <20180115083916.z7wn5cwungywyevh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 14, 2018 at 03:07:46PM +0800, Hao Zhang wrote:
> 2018-01-11 20:47 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > On Thu, Jan 11, 2018 at 07:33:23PM +0800, hao_zhang wrote:
> >> This patch add pwm pins for r40.
> >>
> >> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> >
> > You should order your patches differently. We try to be as bisectable
> > as possible, and if we just apply this patch the DT will not compile
> > anymore.
> >
> > Your patch 4 should come before this one.
> >
> 
> Do you mean that the order of patch be applied is from the first to
> the last in the patch set ?

Yes and each steps should compile and not introduce any regressions
(ideally :)).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/d62f8f86/attachment.sig>
