From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jul 2017 09:51:38 +0200
Subject: [PATCH 03/12] ARM: normalize clk API for older platforms
In-Reply-To: <89c62838-ce8c-cb83-fca9-73cbc41d590c@nokia.com>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155132.3250812-1-arnd@arndb.de>
 <89c62838-ce8c-cb83-fca9-73cbc41d590c@nokia.com>
Message-ID: <CAK8P3a0e=yY5F_BgtfR8i_XduxLwA9eZq7zkrt-rBD97uqgKCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 6:04 PM, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> On 20/07/17 17:50, Arnd Bergmann wrote:
>
> I've sent the patch implementing this properly several times already
> (the last one "[PATCH v5 1/5] clk: ep93xx: Implement clk_get_parent()"
> on 04.06.2017) and this is really required for the ADC driver which
> comes along with the series.
>
> I don't mind if you take mine or implement it within your patch,
> but I'd like to see the working function merged.

Hi Alexander,

Sorry for missing your patch.  Of course we should just take that version
then. I'll drop the ep93xx part of my patch. When you send your version
for inclusion, please also add a clk_set_parent()/clk_get_parent()
implementation doing whatever you feel is right.

        Arnd
