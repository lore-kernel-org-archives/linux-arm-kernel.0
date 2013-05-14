From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 14 May 2013 21:35:20 +0100
Subject: [PATCH v2 2/3] clk: add support for clock reparent on set_rate
In-Reply-To: <20130514181318.10068.79002@quantum>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <1366388904-13903-3-git-send-email-james.hogan@imgtec.com>
 <20130514181318.10068.79002@quantum>
Message-ID: <CAAG0J9_ScDGDvk4NF_ojLb1MgB0mA60htR3ay2Z4EvFvNRT1Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2013 19:13, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting James Hogan (2013-04-19 09:28:23)
>> Add core support to allow clock implementations to select the best
>> parent clock when rounding a rate, e.g. the one which can provide the
>> closest clock rate to that requested. This is by way of adding a new
>> clock op, determine_rate(), which is like round_rate() but has an extra
>> parameter to allow the clock implementation to optionally select a
>> different parent clock. The core then takes care of reparenting the
>> clock when setting the rate.
>>
>
> Hi James,
>
> Can you rebase this onto -rc1?  It does not apply cleanly.

Hi Mike,

Sure, I rebased onto clk-next the other day so I'll update to rc1 and
resubmit tomorrow.

Cheers
James
