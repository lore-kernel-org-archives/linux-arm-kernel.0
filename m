From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Jan 2015 09:40:10 -0800
Subject: [PATCH 2/4] ARM: tegra: Move out nyan-generic parts out from the
 nyan-big DT
In-Reply-To: <CAL1qeaETERAm6aTwWycCat-RzQz8UmixWtc-uK4dFsu7wL8HAg@mail.gmail.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
 <1420540653-14816-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150106130656.GF31830@ulmo.nvidia.com>
 <CAL1qeaETERAm6aTwWycCat-RzQz8UmixWtc-uK4dFsu7wL8HAg@mail.gmail.com>
Message-ID: <CAOesGMj5EFr89SvskxjwjG8UdVPMJLO4-Up_5WLPUabqyqmXNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 6, 2015 at 9:30 AM, Andrew Bresticker <abrestic@google.com> wrote:
> On Tue, Jan 6, 2015 at 5:06 AM, Thierry Reding <thierry.reding@gmail.com> wrote:

>>
>> Back when we merged the nyan-big DTS there was some discussion and it
>> was concluded that the devices are very similar, with the panel being
>> one notable exception. So I think that this belongs in the nyan-big
>> DTS and you need to add a similar property to the nyan-blaze DTS with
>> the compatible for the panel used in the design. And you might need
>> to add an entry for the panel in the panel-simple driver, too.
>
> That's correct.  There are also variants of big and blaze with 1080p
> panels, so those will definitely need their own panel nodes as well.
>
> Other than that,
>
> Acked-by: Andrew Bresticker <abrestic@chromium.org>

Shame on both of you for not pruning the patch when replying -- the
emails go too long for gmail to show them by default. :) :P

And yeah, this split looks reasonable to me (with the panel comment fixed)

Feel free to carry:

Acked-by: Olof Johansson <olof@lixom.net>
