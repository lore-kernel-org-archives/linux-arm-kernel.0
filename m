From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 24 Jul 2017 22:51:37 +0530
Subject: [PATCH 3/9] firmware: arm_scmi: add basic driver infrastructure
 for SCMI
In-Reply-To: <cd935dab-06b8-a91b-d393-cfc2f085c600@arm.com>
References: <1498492513-29771-4-git-send-email-sudeep.holla@arm.com>
 <1499446341-5956-1-git-send-email-jaswinder.singh@linaro.org>
 <5f2e4f3c-297b-c5f8-9244-399c1c4e2c21@arm.com>
 <CABb+yY3Xo-meg5bTZ5Cj1DAvf_0yOw0QB5Kq6U7VG+L_L+Mo3w@mail.gmail.com>
 <f165d171-a55b-662f-888c-3be2c3e8f11a@arm.com>
 <CABb+yY3NNUE7YXAhBLpMzVZkB7Kgx6iZk8a--crHa9Wpw6Ls4Q@mail.gmail.com>
 <cd935dab-06b8-a91b-d393-cfc2f085c600@arm.com>
Message-ID: <CABb+yY0tX3kgAPTYOSqVMXwVPXFBYGwdwo5gy+TgdtRpZkwx6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 9:51 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 24/07/17 16:41, Jassi Brar wrote:

>> SCMI  calls
>>     mbox_send_message(struct mbox_chan *chan, struct scmi_xfer *xfer);
>>
>> whereas the API expects
>>     mbox_send_message(struct mbox_chan *chan, struct controller_specific *xfer);
>>
>
> That's not hard to change ...

Cool, please change it and lets move on.
