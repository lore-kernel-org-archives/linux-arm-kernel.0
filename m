From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 16 May 2016 19:13:17 +0800
Subject: [PATCH 2/3] mfd: axp20x: Extend axp22x_volatile_ranges
In-Reply-To: <1463248289-16456-2-git-send-email-hdegoede@redhat.com>
References: <1463248289-16456-1-git-send-email-hdegoede@redhat.com>
 <1463248289-16456-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65nuj4Uh9jNSS4wk8CWkgN6iiuGR2vz4Kat=8QT68EE6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 15, 2016 at 1:51 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The axp22x pmic has a bunch of volatile registers besides the interrupt
> ones, extend axp22x_volatile_ranges with these.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
