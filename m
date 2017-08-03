From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 3 Aug 2017 12:30:49 +0800
Subject: [PATCH] This patch adds support for Sinovoip BPI-M3 A83T based
 board.
In-Reply-To: <1501716302-1009-1-git-send-email-embed3d@gmail.com>
References: <1501716302-1009-1-git-send-email-embed3d@gmail.com>
Message-ID: <CAGb2v65-jo4ejgrWOtWE1-yJMYOP=CXHux2Os-a99GRrXa3o=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 3, 2017 at 7:25 AM, Philipp Rossak <embed3d@gmail.com> wrote:
> From: Philipp Rossak <embed3d@gmail.com>
>
> It has 2G LPDDR3, UART, ethernet, USB, HDMI, USB Sata, MIPI DSI,
> mic, AP6212 Wifi, etc on it.
> It is paired with AXP813 PMIC which is almost same as AXP818.
>
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>
> This Patch got somehow lost. This is a resubmit! The original patch
> could be found here: https://patchwork.ozlabs.org/patch/598497/

This didn't get merged because the original patch sets dealt with
a lot of stuff that wasn't settled.

Also, you should keep the author when resending patches.

Finally, I have a more complete version that I plan to send soon:

https://github.com/wens/linux/commit/240a2492b3379646e2f497d5ade7014ff955f818

Note that the dts file name is changed to bananapi-m3, to match
what we have for most of the other bananapi boards.

ChenYu
