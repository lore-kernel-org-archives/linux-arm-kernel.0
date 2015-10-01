From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 1 Oct 2015 23:05:12 +0200
Subject: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <20151001173554.GB19319@codeaurora.org>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <17200614.QxCe8zAb7I@diego>
 <CAPDyKFpis8XnvrppHq7q_7DQeN2UiEpykNTJ=1iJJ9AGOHTW6Q@mail.gmail.com>
 <2695161.Z1IhqPE0bd@diego> <20151001173554.GB19319@codeaurora.org>
Message-ID: <CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/01, Heiko St?bner wrote:
>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
>> > On 30 September 2015 at 16:55, Heiko St?bner <heiko@sntech.de> wrote:
>> > > Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
>> > >> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de> wrote:
>> > > The clock changes of course only touch internals of the phase-clocks, so
>> > > should have no problem going through another tree.
>> >
>> > What happens if I take mmc and dt changes, wouldn't I need the clock
>> > patches as well?
>>
>> The API stays of course the same, only the degree to settings translation gets
>> optimized, so I guess in the worst case you would get no good phase and thus
>> fall back to non-highspeed modes - but the system would stay running.
>>
>> But of course, if the clock maintainers could Ack the two clock patches and
>> everything would stay together that would work even better :-)
>>
>
> If Ulf doesn't want to take them we can apply them to clk tree.
> Otherwise, you can have my acked-by on the clk patches.

I don't mind picking up the clock patches. So I consider this as an
ack for both patch 1 and patch2, thanks.

Now, let's give Jaehoon some time to review the dw_mmc parts.

Kind regards
Uffe
