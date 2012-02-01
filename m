From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2012 23:45:37 -0800
Subject: [PATCH] ARM: tegra: Add pinmux board file for Cardhu
In-Reply-To: <20120201073926.GG7399@quad.lixom.net>
References: <1327511715-27350-1-git-send-email-swarren@nvidia.com>
 <20120201073926.GG7399@quad.lixom.net>
Message-ID: <CAOesGMjU5NvXy+jh0xVz_zZv4kQT2PNRevhvU4j2ruDShDQGFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 11:39 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 25, 2012 at 10:15:15AM -0700, Stephen Warren wrote:
>> For now, this just sets up the pinmux and GPIOs required for the SD
>> card slot.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> ---
>> This will hopefully be replaced by the pinmux DT binding in the near
>> future, but until that happens, Tegra30 pinmux functionality needs to
>> be exposed somehow to unblock getting drivers tested on Tegra30.
>>
>> This of course depends on my recently posted patches that implement a
>> pinctrl subsystem driver for Tegra.
>>
>> (Peter said: Boot tested on Cardhu, MMC still doesn't work but that might
>> have another rootcause...)
>
> Thanks, applied.

Actually, dropped again until the pinctrl stuff lands for the obvious
reason. I'll revisit shortly.


-Olof
