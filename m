From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 2 Jan 2014 10:41:23 +0800
Subject: [PATCH v3 3/5] ARM: dts: sun7i: external clock outputs
In-Reply-To: <20140101231039.GG3144@lukather>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
 <1388543450-16741-4-git-send-email-wens@csie.org>
 <20140101231039.GG3144@lukather>
Message-ID: <CAGb2v66WrvasyFohuGhYvTPNHwh1VdUejMa8m8QTakg6BPG-uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 2, 2014 at 7:10 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Jan 01, 2014 at 10:30:48AM +0800, Chen-Yu Tsai wrote:
>> This commit adds the two external clock outputs available on A20 to
>> its device tree. A dummy fixed factor clock is also added to serve as
>> the first input of the clock outputs, which according to AW's A20 user
>> manual, is the 24MHz oscillator divided by 750.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I'm ok with this patch, but I'll let Emilio and Mike give their
> opinion on the driver before merging it.

The driver has not changed since v1.
Mike merged it via Emilio's pull request.

Or are you referring to the DT part?


Cheers,
ChenYu
