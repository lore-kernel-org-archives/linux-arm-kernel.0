From: cjb@laptop.org (Chris Ball)
Date: Wed, 10 Aug 2011 05:48:47 -0400
Subject: [PATCH V4] mmc: Enable the ADMA2 on esdhc imx driver
In-Reply-To: <CAMPhdO8QiODg6sTKe2N2b4xT8ZHXSh1DvRn57J8JfLx6+QAD4w@mail.gmail.com>
	(Eric Miao's message of "Wed, 10 Aug 2011 16:08:53 +0800")
References: <1312792204-7652-1-git-send-email-richard.zhu@linaro.org>
	<CAMPhdO8QiODg6sTKe2N2b4xT8ZHXSh1DvRn57J8JfLx6+QAD4w@mail.gmail.com>
Message-ID: <m27h6ltx4w.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 10 2011, Eric Miao wrote:
> On Mon, Aug 8, 2011 at 4:30 PM, Richard Zhu <richard.zhu@linaro.org> wrote:
>> Eanble the ADMA2 mode for freescale esdhc imx driver,
>> tested on MX25 3DS board, MX51 BBG board and MX53 LOCO board.
>>
>> This patch is only used to enable the ADMA2 for MX51/53 platforms.
>> MX25/35 can't support the ADMA2 mode, set BROKEN_ADMA quirk on
>> MX25/35 platforms.
>>
>> The ADMA mode supported or not can be distinguished by the
>> bit20 of Capability Register(offset 0x40) in FSL eSDHC module.
>>
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>
> Tested-and-acked-by: Eric Miao <eric.miao@linaro.org>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
