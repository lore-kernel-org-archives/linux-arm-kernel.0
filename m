From: olof@lixom.net (Olof Johansson)
Date: Fri, 22 Jan 2016 08:30:48 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.5
In-Reply-To: <cover.1453343917.git.horms+renesas@verge.net.au>
References: <cover.1453343917.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMi-S9XiBLaV5kvXG=fPDV2V0TybEZRxDuyGORyw0mPp4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 6:41 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v4.5.
>
> This corrects the extal1 frequency on the armadillo800eva board.
> This problem seems to have been around for a while and I would
> like it considered for stable.


If you want it for stable you should cc stable in the
signed-off-series, or send it separately to Greg. We usually don't
filter out on our own due to volume.

Merged the branch. Thanks!


-Olof
