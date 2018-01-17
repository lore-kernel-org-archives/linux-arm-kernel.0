From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Jan 2018 17:54:32 +0100
Subject: [PATCH] exynos: drm: use monotonic timestamps
In-Reply-To: <f6a26bf4-e3b6-97c1-3a92-00ffe97ae293@math.uni-bielefeld.de>
References: <20171102114415.1811842-1-arnd@arndb.de>
 <f6a26bf4-e3b6-97c1-3a92-00ffe97ae293@math.uni-bielefeld.de>
Message-ID: <CAK8P3a0881PmcN4vga-oMWvHkWytvvu96Psr3PR2thNti5KQ5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 3:04 PM, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> Hello Arnd,
>
> I guess you could coordinate the IPP changes with Marek, who is rewriting the
> IPP subsystem anyway (added Marek to Cc).
>
> Here is the most recent IPPv2 series:
> https://www.spinics.net/lists/linux-samsung-soc/msg61066.html
>
> Concerning the G2D changes, I don't think anything in userspace uses the
> timestamps (e.g. for synchronisation).

I'm cleaning out older patches that didn't make it in yet now, and got to this
one. I looked at the current state and found that the ipp specific half of my
patch is obsolete now, and we won't need to patch anything there with
Marek's new version.

For the G2D half, I'll just resubmit the patch I had here, let's discuss
further from there, if you think we should just drop the timestamp.

Thanks!

       Arnd
