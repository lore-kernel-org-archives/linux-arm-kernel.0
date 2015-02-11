From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 11 Feb 2015 09:26:13 -0800
Subject: [PATCH v4 02/11] ARM: tegra: Move out nyan-generic parts out from
 the nyan-big DT
In-Reply-To: <1423667220-1062-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1423667220-1062-1-git-send-email-tomeu.vizoso@collabora.com>
 <1423667220-1062-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAL1qeaHeB6vikVWquGM7psdKPKc0FVqj5-xuc3PXbJhok1vGoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On Wed, Feb 11, 2015 at 7:06 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> In preparation for adding the DT for the nyan-blaze board.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Maybe it's worth pulling the common pinmux bits into nyan.dtsi as well?

Otherwise,
Acked-by: Andrew Bresticker <abrestic@chromium.org>
