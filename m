From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 3 Jun 2016 09:39:24 +0800
Subject: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66_UMf-fccSoPoJKJmygLXU8kYOq6RrwDPiq_Q6+kTARg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 1:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
