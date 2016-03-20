From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Mar 2016 00:05:08 +0800
Subject: [PATCH 0/8] ARM: dts: sun8i: Orangepi Plus dts improvements
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65THg3fcdTJvFBCxxbSU_vOWmB9tP4f2QUbPyUU9D=zig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 21, 2016 at 12:00 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Maxime and Chen-Yu,
>
> Here is a series with various improvements for the Orangepi Plus dts.
> Some (most) of these patches have been submitted before, esp. the USB
> ones have multiple revisions before. But I lost count of their version,
> so I'm posting this as a "new" set.
>
> About the USB patches, these rely on the patches to add support for
> multiple-reset controllers to ohci-platform / ehci-platform. These
> patches are all acked up and will go upstream as soon as v4.6-rc1 is
> released (they depend on changes which will go into v4.6-rc1).

Does this mean you or I can send the Orange Pi PC DTS patch?

Thanks
ChenYu

> The old ohci-platform / ehci-platform will only look at the first reset
> specified in the dt and as such will fail to load with the new dt nodes
> (because they cannot talk to the controller).
>
> I've also included a v6 of Krzysztof Adamski <k@japko.eu> leds / switches
> patch, fixing the comments you had in your review of v5. I've done this
> to avoid conflicts with my other patches.
>
> Regards,
>
> Hans
