From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 15:48:17 +0800
Subject: [PATCH v3 00/14] ARM: dts: sunxi: Fix DT build warnings
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v64AK-xifjcowUk1mp4TRwHFPOqjZR58Bd5w7Bei52T06g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 3:22 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> Hello
>
> The goal of this patch series is to have a clean DT build with W=1.
>
> Regards
>
> Changes since v1:
> - moved i2c2 unit address change from patch #2 in patch #1
>
> Changes since v2
> - added two patch for fixing pin names

The first twelve patches are good. Maxime, I think we can go ahead and
merge them, instead of having them resent again in v3?

The last two patches are not what I asked for though.

ChenYu
