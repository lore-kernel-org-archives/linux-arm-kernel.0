From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 27 Feb 2017 14:26:03 +0100
Subject: [RESEND PATCH] PM / AVS: rockchip-io: add io selectors and
 supplies for rk3328
In-Reply-To: <m2innw39on.fsf@baylibre.com>
References: <1487853191-10994-1-git-send-email-david.wu@rock-chips.com>
 <m2innw39on.fsf@baylibre.com>
Message-ID: <5273870.ds1UUp6ZfE@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, February 26, 2017 01:48:40 PM Kevin Hilman wrote:
> David Wu <david.wu@rock-chips.com> writes:
> 
> > From: "david.wu" <david.wu@rock-chips.com>
> >
> > This adds the necessary data for handling io voltage domains on the rk3328.
> > As interesting tidbit, the rk3328 only contains one iodomain area in the
> > regular General Register Files (GRF).
> >
> > Signed-off-by: david.wu <david.wu@rock-chips.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> Rafael, feel free to take directly.  I don't currently have any other
> AVS stuff in the queue.

I'll queue it up for 4.12 then.

Thanks,
Rafael
