From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 14 Jan 2017 15:40:21 -0200
Subject: [PATCH RFC] mmc: mxs-mmc: Implement CMD23 support
In-Reply-To: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
References: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5Czy17FytjyHP_pHHqCetDiYyOHaVOFu5hZHjAD=8rHUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sat, Jan 14, 2017 at 3:29 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch implements support for multiblock transfers bounded
> by SET_BLOCK_COUNT (CMD23) on the MXS MMC host driver.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Just curious: what is the throughput gain you notice with this patch?

Thanks
