From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Oct 2016 10:34:39 +0800
Subject: [PATCH 7/9] ARM: sunxi: Remove useless allwinner,drive property
In-Reply-To: <01cd77ccced851276fcb3625b3d7805f5260fb59.1475489558.git-series.maxime.ripard@free-electrons.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <01cd77ccced851276fcb3625b3d7805f5260fb59.1475489558.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65SmZqR-MJgNxa0RGUYyWgeLHQcQfa0b8U0XiEtp+RfBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The allwinner,drive property set to 10mA was really considered as our
> default. Remove all those properties entirely to make that obvious.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Did you use sed or some other scripting tool to do this patch?
Including the command should make it easier to verify the result,
instead of having to go through the 93 files here.

ChenYu
