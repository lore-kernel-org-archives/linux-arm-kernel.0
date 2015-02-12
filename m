From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 12 Feb 2015 07:18:47 +0100
Subject: [PATCH v4 02/11] ARM: tegra: Move out nyan-generic parts out
 from the nyan-big DT
In-Reply-To: <CAL1qeaHeB6vikVWquGM7psdKPKc0FVqj5-xuc3PXbJhok1vGoA@mail.gmail.com>
References: <1423667220-1062-1-git-send-email-tomeu.vizoso@collabora.com>	<1423667220-1062-3-git-send-email-tomeu.vizoso@collabora.com>
 <CAL1qeaHeB6vikVWquGM7psdKPKc0FVqj5-xuc3PXbJhok1vGoA@mail.gmail.com>
Message-ID: <54DC45C7.8020907@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2015 06:26 PM, Andrew Bresticker wrote:
> Hi Tomeu,
> 
> On Wed, Feb 11, 2015 at 7:06 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> In preparation for adding the DT for the nyan-blaze board.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> Maybe it's worth pulling the common pinmux bits into nyan.dtsi as well?

I decided to have them in the leaf DTSs so the whole output from
tegra-pinmux-scripts can be stuck in there without any extra processing.

I think this way we can be more certain that the pinmux in the kernel
isn't diverging from what it should be.

> Otherwise,
> Acked-by: Andrew Bresticker <abrestic@chromium.org>

Thanks,

Tomeu
