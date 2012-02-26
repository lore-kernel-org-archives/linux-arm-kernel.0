From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 14:14:19 -0800
Subject: [PATCH V2 1/2] ARM: tegra: Add pinmux board file for Cardhu
In-Reply-To: <20120226215141.GA11189@quad.lixom.net>
References: <1328138997-25665-1-git-send-email-swarren@nvidia.com>
 <20120226215141.GA11189@quad.lixom.net>
Message-ID: <CAOesGMj4BHL6A1Ej4nQpTkjAY3Z=MKfncc5H8DFwh4TTvPixnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 1:51 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Feb 01, 2012 at 04:29:56PM -0700, Stephen Warren wrote:
>> For now, this just sets up the pinmux and GPIOs required for the SD
>> card slot.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> v2:
>> * Set PULL_UP for CMD and DATA pins on SD interface
>> * Add power GPIO for SDMMC1
>> * Add pinmux configuration for SDMMC4
>>
>> This will hopefully be replaced by the pinmux DT binding in the near
>> future, but until that happens, Tegra30 pinmux functionality needs to
>> be exposed somehow to unblock getting drivers tested on Tegra30.
>
> Thanks, applied to for-3.4/boards.

...and I'm two for two on sending the apply email before I have
checked dependencies.

This doesn't build, so I dropped it again. Probably a missing
dependency on pinctrl changes but please revisit on top of just the
tegra code and let me know.


-Olof
