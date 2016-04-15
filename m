From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 15 Apr 2016 17:18:03 +0100
Subject: [PATCH V2 04/15] coresight: tmc: introducing new header file
In-Reply-To: <CANLsYkxL1c=RioUsT+1U49fcf=fGFFFedFTyOP20tuTxg3a15A@mail.gmail.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-5-git-send-email-mathieu.poirier@linaro.org>
 <570FD473.9090007@arm.com>
 <CANLsYkzQuF=Y7O7T41HHHGHiFNtpj+cUd8W9paAYh=dqm0MJXg@mail.gmail.com>
 <571111E8.2000804@arm.com>
 <CANLsYkxL1c=RioUsT+1U49fcf=fGFFFedFTyOP20tuTxg3a15A@mail.gmail.com>
Message-ID: <5711143B.1020700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 17:15, Mathieu Poirier wrote:
> On 15 April 2016 at 10:08, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 15/04/16 17:03, Mathieu Poirier wrote:
>> I agree. But the patch which introduces the definition doesn't deal with
>> TMC_STS_ at all either.
>
> Patch 13/15 is using the TMC_STS_FULL define on line 147.  Am I
> missing your point?

Ah, sorry, didn't see that TMC_STS_FULL was used there. Ignore my comments.
