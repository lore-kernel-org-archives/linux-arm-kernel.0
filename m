From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Tue, 3 Apr 2018 22:08:39 +0200
Subject: [PATCH v5 11/13] ARM: sun9i: smp: Add is_sun9i field
In-Reply-To: <CAGb2v67EzOHd5_Xj9K3ZuAKVZhA4WrwfTM0gE_eR+H4mF1J4eA@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-12-mylene.josserand@bootlin.com>
 <20180403084655.x6u7s4jzqdvq2eey@flea>
 <CAGb2v67EzOHd5_Xj9K3ZuAKVZhA4WrwfTM0gE_eR+H4mF1J4eA@mail.gmail.com>
Message-ID: <20180403220839.0ec8f9b8@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 3 Apr 2018 16:48:41 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Tue, Apr 3, 2018 at 4:46 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 03, 2018 at 08:18:34AM +0200, Myl?ne Josserand wrote:  
> >> To prepare the support of sun8i-a83t, add a field in the smp_data
> >> structure to enable the case of sun9i.
> >>
> >> Start to handle the differences between sun9i-a80 and sun8i-a83t
> >> by using this variable.
> >>
> >> Add an index to retrieve which structures we are using.  
> >
> > This should have been in a separate commit, but maybe we can store a
> > pointer to the array cell we're using instead of always using the
> > index?  
> 
> Using a pointer would also avoid some of the code movement from the
> previous patch.
> 
> ChenYu

Yep, I will use a pointer instead. Thanks for the correction.

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
