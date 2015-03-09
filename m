From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 9 Mar 2015 14:00:27 -0700
Subject: [PATCH v5 1/8] PM / Domains: Add DT bindings for power-on/off
 latencies
In-Reply-To: <1416231044-1903-2-git-send-email-geert+renesas@glider.be>
References: <1416231044-1903-1-git-send-email-geert+renesas@glider.be>
 <1416231044-1903-2-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMAWPa-PROLJVGU2w8FSJYt4YJehc2DAnaT047fukSTAM9Eddw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Mon, Nov 17, 2014 at 5:30 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.

Any plans to refresh/resend this patch now that the rest of the series
has gone in?

I'm seeing some other PM domain series coming in for review[1] that
could use this feature.

Thanks,

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328905.html
