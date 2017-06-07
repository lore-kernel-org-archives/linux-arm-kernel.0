From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Jun 2017 15:37:48 +0800
Subject: [PATCH v10] sun4i-codec: Add mixer controls: Line-In, FM-In, Mic
 2, Capture Source, Differential Line-In.
In-Reply-To: <20170607072718.18017-2-dannym@scratchpost.org>
References: <20170607072718.18017-1-dannym@scratchpost.org>
 <20170607072718.18017-2-dannym@scratchpost.org>
Message-ID: <CAGb2v641CX=rM_2shHoM1XxMp82gwFMz-Y_95RBhP5jbjmU7dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 7, 2017 at 3:27 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Adds support for some mixer controls to sun4i-codec:
>  - Line-In
>  - FM-In
>  - Mic 2
>  - Capture Source
>  - Differential Line-In
>
> It also adds a mux for the capture source and the PGA for the MIC2 preamp.
>
> Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
> of distinct controls in alsamixer.

You are doing too many things in one patch.

Please split this up into 1 patch per control/mux/source/widget added,
preceded by patches for any required cleanups.

ChenYu

> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
