From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 17 Sep 2014 21:37:59 -0700
Subject: [PATCH] ARM: DT: ifc6410: Add board memory range.
In-Reply-To: <541A01F3.4020303@linaro.org>
References: <1410932179-4652-1-git-send-email-srinivas.kandagatla@linaro.org>
 <54192B64.6070604@smartplayin.com>
 <FA9D8682-DB0E-48CF-A519-86A0465300E1@codeaurora.org>
 <20140917191829.GC3749@joshc.qualcomm.com>
 <541A01F3.4020303@linaro.org>
Message-ID: <CAJAp7Og5v-ADm6ekMVUs8++CL5NP+OEw-vZ7mKdChOZyBTBZpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 2:49 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 17/09/14 20:18, Josh Cartwright wrote:
>>
>> On Wed, Sep 17, 2014 at 12:03:37PM -0700, Kumar Gala wrote:
[..]
>>> Hmm, this doesn?t seem to work for me.
>>
>>
>> I don't see how it could with qcom_defconfig, as we set
>> CONFIG_ARM_ATAG_DTB_COMPAT.  Is this patch fixing a real issue?
>
> No, its not fixing any thing by itself.
>
> However along with "ARM: zImage: Allow DTB to override broken ATAG_MEM"
> patch atleast I get to boot my IFC6410 with multi_v7_defconfig.

But that patch was rejected by various people.
Instead have a look at [1], it solves the problem for you (and have
reference to the original source).

[1] https://github.com/andersson/kernel/commit/d4c0061cf7be8a341e6d06a97c85ecb69284e74c

Regards,
Bjorn
