From: dianders@chromium.org (Doug Anderson)
Date: Mon, 25 Aug 2014 08:50:07 -0700
Subject: [PATCH] clk: rockchip: Fix the clocks for i2c1 and i2c2
In-Reply-To: <4584014.Iu24cpYxxY@phil>
References: <1408725508-24066-1-git-send-email-dianders@chromium.org>
 <4584014.Iu24cpYxxY@phil>
Message-ID: <CAD=FV=XH4wj-3vCobd_D5F1-Ef_jrLm-=hv8MknUBcYVLg5Jzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 22, 2014 at 9:46 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Freitag, 22. August 2014, 09:38:28 schrieb Doug Anderson:
>> The clocks for i2c1 and i2c2 are flipped.  The clock tree matched the
>> Technical Reference Manual (TRM) but the TRM was wrong.  Swap them in
>> the clock tree.  This was determined experimentally (by Addy) and
>> confirmed by the Rockchip IC team.
>>
>> Seires-cc: Eddie Cai <eddie.cai@rock-chips.com>
>
> I guess this is a typo...
>
>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Reported-by: Addy Ke <addy.ke@rock-chips.com>
>
> The error-case we discussed yesterday was quite clear, so
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Just in case anyone reading was wondering: I've now received a new
version of the TRM (technical reference manual) the confirms the
correctness of this patch.

Mike: maybe you could apply it to 3.17 fixups?

-Doug
