From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 11:00:26 -0800
Subject: [PATCH v2 1/6] ARM: tegra: do not hide dma declarations
In-Reply-To: <20120304183513.GA31064@quad.lixom.net>
References: <1330721903-8571-1-git-send-email-alan@signal11.us>
 <20120304183513.GA31064@quad.lixom.net>
Message-ID: <CAOesGMg4nBjUGb_KzZk1_d2FvCmbW2kwFqh9q_9S8TQqgYO8hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 4, 2012 at 10:35 AM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Mar 02, 2012 at 03:58:23PM -0500, Alan Ott wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The declarations are actually required for the device
>> definitions, and are still valid even if the dma controller
>> is disabled:
>>
>> arch/arm/mach-tegra/devices.c:559:12: error: 'TEGRA_DMA_REQ_SEL_I2S_1' undeclared here (not in a function)
>> arch/arm/mach-tegra/devices.c:577:12: error: 'TEGRA_DMA_REQ_SEL_I2S2_1' undeclared here (not in a function)
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Alan Ott <alan@signal11.us>
>
> Thanks, applied to cleanups-and-fixes for 3.4.

Oh, a corresponding fix for this is already in mainline, so I dropped
it again (noticed due to conflicts).


-Olof
