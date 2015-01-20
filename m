From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 21 Jan 2015 00:09:05 +0800
Subject: [PATCH v5] clk: sunxi: Add driver for A80 MMC config clocks/resets
In-Reply-To: <20150120160413.GU4367@lukather>
References: <1421768791-20170-1-git-send-email-wens@csie.org>
 <20150120160413.GU4367@lukather>
Message-ID: <CAGb2v65y0KPe7UtguEEPJyFtBD7qoJ=-YT82Mwp+qDPi7PCPYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 12:04 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jan 20, 2015 at 11:46:31PM +0800, Chen-Yu Tsai wrote:
>> On the A80 SoC, the 4 mmc controllers each have a separate register
>> controlling their register access clocks and reset controls. These
>> registers in turn share a ahb clock gate and reset control.
>>
>> This patch adds a platform device driver for these controls. It
>> requires both clocks and reset controls to be available, so using
>> CLK_OF_DECLARE might not be the best way.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Merged, thanks!

plaes on IRC just pointed out the copyright year is wrong....

Could you fix it before you push it out?
Sorry about this.

ChenYu
