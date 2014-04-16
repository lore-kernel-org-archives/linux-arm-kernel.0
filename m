From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 16 Apr 2014 15:12:26 +0900
Subject: [PATCH 1/7] gpiolib: gpiolib-of: Implement device tree gpio-names
 based lookup
In-Reply-To: <20140415142024.GD3207@lukather>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-2-git-send-email-wens@csie.org>
 <20140415142024.GD3207@lukather>
Message-ID: <CAAVeFuLDhTVGDnmYtnxEY8hhn6HE6tU9OB24WDPtmxEHjiRiuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 11:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Tue, Apr 15, 2014 at 02:41:35PM +0800, Chen-Yu Tsai wrote:
>> This patch provides of_get_gpiod_flags_by_name(), which looks up GPIO
>> phandles by name only, through gpios/gpio-names, and not by index.
>
> IIRC, gpios only uses the *-gpios properties, and not gpios/gpio-names
> pattern seen on various other things.
>
> Is it some new property you introduce? If so, please add it to the
> documentation.
>
> Now, I'm not sure that having two distinct representations of GPIOs in
> the DT is a good thing. Yes, it's looking odd compared to other
> similar bindings, but it's what we have to deal with.

Mmmm I *think* I somehow remember a discussion about this topic
recently, but I cannot find it. Maybe Chen-yu could point us to the
conclusion of this discussion and the rationale for (re)implementing
named GPIOs this way?
