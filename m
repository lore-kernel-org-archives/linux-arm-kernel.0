From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Jun 2016 15:01:52 +0800
Subject: [PATCH 2/3] ARM: dts: sun6i: The blue led on the Mele A1000G quad
 is a power led
In-Reply-To: <1465129393-22379-2-git-send-email-hdegoede@redhat.com>
References: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
 <1465129393-22379-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67fSH=d8Aw=Pk2zMd=wmiBpaO2hbRiMxqCAUfmisGB6ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 5, 2016 at 8:23 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The blue led on the Mele A1000 is wired to light up as soon as the board
> has powered (it will be on while the gpio is still in input / floating
> mode), also its location on the top-set box clearly signals "power led".
>
> Until now we've been treating this as a generic usr function led, which
> means that when you plug power into the top-set box, the power-led lights
> and then turns off as soon as the kernel loads, which looks wrong.
>
> This renames the led from m9:blue:usr to a1000g:blue:pwr (fixing a copy
> and paste error in the prefix while at it) and marks it as default on,
> fixing this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
