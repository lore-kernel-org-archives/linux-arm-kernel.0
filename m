From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Sep 2016 08:10:28 -0500
Subject: [PATCH] ARM: dts: explicitly mark skeleton.dtsi as deprecated
In-Reply-To: <20160901124611.GA5049@leverpostej>
References: <1472730037-4972-1-git-send-email-mark.rutland@arm.com>
 <20160901124611.GA5049@leverpostej>
Message-ID: <CAL_JsqLCrjWR6dN-u08iiv5xzbLvQZ_=qLz4YWYTrkPJLSTazQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 7:46 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 01, 2016 at 12:40:37PM +0100, Mark Rutland wrote:
>> As noted in commit 3ebee5a2e141496b ("arm64: dts: kill skeleton.dtsi"),
>> there are a number of problems with skeleton.dtsi, and it would be
>> prefereable to remove it entirely. As there are a large number of
>> existing users, fixing these up will take a while.
>>
>> This patch adds a note to arm's skeleton.dtsi noting that this is the
>> case, to make this more obvious and hopefully minimize new uptake of
>> skeleton.dtsi in the mean time.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Rob Herring <rob.herring@arm.com>
>
> This should have been linaro.org. not sure how I managed that.

Well, kernel.org really.

I was going to ask if we were getting close with the recent activity,
but I just looked and no there's still a ton.

Acked-by: Rob Herring <robh@kernel.org>
