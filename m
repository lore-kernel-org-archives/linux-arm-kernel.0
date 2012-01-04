From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Jan 2012 19:46:17 -0800
Subject: [PATCH 4/9] arm/tegra: fuse: add functions to access chip revision
In-Reply-To: <20111223104751.GA22157@rhein.zuhause.netz>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-5-git-send-email-olof@lixom.net>
 <20111223104751.GA22157@rhein.zuhause.netz>
Message-ID: <CAOesGMiyG63w5WH7m9ig8rp0p0Ug_D5kcoRLS76SxCTOHjQ=tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 23, 2011 at 2:47 AM, Henning Heinold
<heinold@inf.fu-berlin.de> wrote:
> On Thu, Dec 22, 2011 at 04:17:43PM -0800, Olof Johansson wrote:
>> +static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
>> + ? ? [TEGRA_REVISION_UNKNOWN] = "unknown",
>> + ? ? [TEGRA_REVISION_A02] ? ? = "A02",
>> + ? ? [TEGRA_REVISION_A03] ? ? = "A03",
>> + ? ? [TEGRA_REVISION_A03p] ? ?= "A03 prime",
>> + ? ? [TEGRA_REVISION_A04] ? ? = "A04",
>> +};
>> +
>
> Hi Olof,
>
> can you please add here [TEGRA_REVISION_A01] = "A01", too. It is used in the nvidia git tree and affects the new beta xorg
> driver.


How does it affect the xorg driver? Do you have hardware that is based
on A01? I wouldn't expect there to be any products out there with it
-- A01 has a handful of errata that is not handled in mainline, etc.


-Olof
