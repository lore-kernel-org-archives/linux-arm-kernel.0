From: dianders@chromium.org (Doug Anderson)
Date: Fri, 22 Aug 2014 09:48:20 -0700
Subject: [PATCH] clk: rockchip: Fix the clocks for i2c1 and i2c2
In-Reply-To: <4584014.Iu24cpYxxY@phil>
References: <1408725508-24066-1-git-send-email-dianders@chromium.org>
 <4584014.Iu24cpYxxY@phil>
Message-ID: <CAD=FV=UmpdzkUDwQyNCRf+N0a-_hn3Hpkr_wwddTJc6Y8x9vfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

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

Doh, let me repost just to make it clear.  Sorry about that!  :(
