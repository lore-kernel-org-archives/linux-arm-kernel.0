From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 7 Sep 2011 11:04:26 +0200
Subject: [PATCH 11/22] OMAP4: powerdomain data: add voltage domains
In-Reply-To: <1314639355-12713-12-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-12-git-send-email-khilman@ti.com>
Message-ID: <CAORVsuVikEPsk=1v_Mcevsu1iyDDQzdHuuKbBJUMRGL5mrLpXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> From: Benoit Cousson <b-cousson@ti.com>
>
> Add voltage domain name to indicate which voltagedomain each
> powerdomain is in.
>
> The fixed voltage domain like ldo_wakeup for emu and wkup power
> domain is added too.
>
> Update the TI copyright date to 2011.
This seems to not be part of this patch.

Ok for the rest of it.

>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> [khilman at ti.com]: renamed wakeup domain: s/ldo_wakeup/wakeup/
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> ?arch/arm/mach-omap2/powerdomains44xx_data.c ? | ? 16 ++++++++++++++++
> ?arch/arm/mach-omap2/voltagedomains44xx_data.c | ? ?5 +++++
> ?2 files changed, 21 insertions(+), 0 deletions(-)
>
...

Regards,
Jean
