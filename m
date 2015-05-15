From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 May 2015 09:47:28 -0700
Subject: [PATCH v2] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <CAGsJ_4xJrCX5Bk=Ry1QhDvQO6jM8VhDvCmFG73HqxM6ZiXq0RA@mail.gmail.com>
References: <1428848090-14638-1-git-send-email-21cnbao@gmail.com>
 <20150514234131.GB31753@codeaurora.org>
 <CAGsJ_4xJrCX5Bk=Ry1QhDvQO6jM8VhDvCmFG73HqxM6ZiXq0RA@mail.gmail.com>
Message-ID: <55562320.9060402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/15 00:39, Barry Song wrote:
>
>>> +static struct atlas7_reset_desc atlas7_reset_unit[] = {
>>> +     {"PWM", 0x0244, 0, 0x0320, 0, &leaf0_gate_lock}, /*0-5*/
>> Style nitpick: Please put some space around the braces here.
>>
>>> +     {"THCGUM", 0x0244, 3, 0x0320, 1, &leaf0_gate_lock},
>>> +     {"CVD", 0x04A0, 0, 0x032C, 0, &leaf1_gate_lock},
>>> +     {"TIMER", 0x04A0, 1, 0x032C, 1, &leaf1_gate_lock},
>>> +     {"PULSEC", 0x04A0, 2, 0x032C, 2, &leaf1_gate_lock},
>> [...]
>>> +
>
> all other issues have been cleared in v3 i sent minutes ago. for this
> one, where do you want the spaces added?
>

I'd prefer it look like:

 { "THCGUM", 0x0244, ..., &leaf0_gate_lock },


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
