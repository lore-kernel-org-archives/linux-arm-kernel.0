From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Dec 2014 13:13:29 -0200
Subject: [PATCH] ARM: dts: imx6qdl: Fix CODA960 interrupt order
In-Reply-To: <20141202142048.GN2411@dragon>
References: <1417188226-21756-1-git-send-email-p.zabel@pengutronix.de>
 <20141202142048.GN2411@dragon>
Message-ID: <CAOMZO5C743HkUkaTu_42xr_0=FD5HxBx1tGPC8Z3gcMrqjbTCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Dec 2, 2014 at 12:20 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Nov 28, 2014 at 04:23:46PM +0100, Philipp Zabel wrote:
>> Commit a04a0b6fed4f ("ARM: dts: imx6qdl: Enable CODA960 VPU") lost the
>> fix for the CODA960 interrupt order during a rebase before being applied.
>> This patch adds the missing bit and brings the interrupts and
>> interrupt-names properties back in sync.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> Applied, thanks.

Could you also apply it into for-next?
