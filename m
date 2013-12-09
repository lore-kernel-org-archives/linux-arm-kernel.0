From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Dec 2013 10:59:38 +0800
Subject: [linux-sunxi] Re: [PATCH 02/10] net: stmmac: Honor DT parameter
 to force DMA store and forward mode
In-Reply-To: <2994980.boLDbkkER8@flatron>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <CAGb2v67ZNtbQm+ZW5v_3wNbz1=oLhXks6gbTSjLYa=Nnoz8w-A@mail.gmail.com>
 <20131207100737.GI24519@lukather> <2994980.boLDbkkER8@flatron>
Message-ID: <CAGb2v64BMNjbbc7j2XesuPEXZV+RnjtP1sAPQ4icU=-wjh3YNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 7, 2013 at 7:06 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Saturday 07 of December 2013 11:07:37 maxime.ripard wrote:
>> On Sat, Dec 07, 2013 at 09:23:27AM +0800, Chen-Yu Tsai wrote:
>> > Point taken. The current implementation will override settings passed from
>> > platform data. ORing the two would be better.
>>
>> Platform_data and DT-based configuration are pretty unlikely to be
>> used together, so ORing it doesn't have much sense.
>
> In fact, the recommended way is to always use platform data alone if it is
> present or try to parse DT otherwise, so no mixing of data from these two
> sources should be done.

Would binding platform data with compatibles, as I did so in this patch
series, be a bad idea then?
