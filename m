From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 16:50:30 +0800
Subject: [PATCH 1/4] ARM: dts: axp22x.dtsi: Disable axp22x ldo_io#
 regulators by default
In-Reply-To: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
References: <1463248650-16611-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66em6Zm8JyRn0kfcfhb8hY+5vGd-mQSgH7dBq=Ghv9MKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 15, 2016 at 1:57 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Use of these as regulators conflicts with use of the gpio pins as
> gpios, so disabled the ldo_io# regulators by default, this avoids
> the regulator core touching them when the pins are used as gpios.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
