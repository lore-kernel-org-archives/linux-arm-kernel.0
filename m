From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 18 Jun 2015 10:06:38 +0200
Subject: [PATCH 03/13] ARM: tegra: Add gpio-ranges property
In-Reply-To: <20150617172554.GX14071@sirena.org.uk>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150617172554.GX14071@sirena.org.uk>
Message-ID: <CAAObsKDRWn6T76VQJd6EBaq1zpMouLC2ZYJ8pEStZHk_bdxV+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2015 at 19:25, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 17, 2015 at 03:42:13PM +0200, Tomeu Vizoso wrote:
>> Specify how the GPIOs map to the pins in Tegra SoCs, so the dependency is
>> explicit.
>
> Can I suggest splitting this sort of patch out of the patch series (and
> similarly the documentation fix you had), or putting them at the end or
> something?  It's pretty confusing that early patches in the series are
> a bit tangential rather than being dependencies for the rest of it.

Agreed, sorry about that.

Thanks,

Tomeu
