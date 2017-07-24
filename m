From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 24 Jul 2017 21:11:48 +0530
Subject: [PATCH 3/9] firmware: arm_scmi: add basic driver infrastructure
 for SCMI
In-Reply-To: <f165d171-a55b-662f-888c-3be2c3e8f11a@arm.com>
References: <1498492513-29771-4-git-send-email-sudeep.holla@arm.com>
 <1499446341-5956-1-git-send-email-jaswinder.singh@linaro.org>
 <5f2e4f3c-297b-c5f8-9244-399c1c4e2c21@arm.com>
 <CABb+yY3Xo-meg5bTZ5Cj1DAvf_0yOw0QB5Kq6U7VG+L_L+Mo3w@mail.gmail.com>
 <f165d171-a55b-662f-888c-3be2c3e8f11a@arm.com>
Message-ID: <CABb+yY3NNUE7YXAhBLpMzVZkB7Kgx6iZk8a--crHa9Wpw6Ls4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 3:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 08/07/17 06:32, Jassi Brar wrote:
>> Hi Roy, Matt, Nishant, Harb Abdulhamid, Loc,
>>
>> I have a gut feeling you guys were part of the SCMI spec committee. If
>> so, could you please chime in?
>>
>
> I take complete silence as no objection.
>
I take it as no self respecting developer/architect would stand by
your FUBAR implementation of SCMI.

SCMI  calls
    mbox_send_message(struct mbox_chan *chan, struct scmi_xfer *xfer);

whereas the API expects
    mbox_send_message(struct mbox_chan *chan, struct controller_specific *xfer);

As the maintainer I have tried to explain it to you in a dozen ways.
If you still can't see how it's broken, you can't be helped.

Checking out until someone else has any point.
NAK.
