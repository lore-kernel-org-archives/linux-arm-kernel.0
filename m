From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Tue, 6 Aug 2013 09:55:44 +0530
Subject: [PATCH 1/3] clk: s2mps11: Add support for s2mps11
In-Reply-To: <20130805232337.5348.79716@quantum>
References: <1373197462-4033-1-git-send-email-yadi.brar@samsung.com>
 <1373197462-4033-2-git-send-email-yadi.brar@samsung.com>
 <20130805232337.5348.79716@quantum>
Message-ID: <CAKew6eXRuB5Q0f_GaCKOR7XwbX0n=-5BR_TeRVMUCD9AUHiL7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Aug 6, 2013 at 4:53 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Yadwinder Singh Brar (2013-07-07 04:44:20)
>> This patch adds support to register three(AP/CP/BT) buffered 32.768 KHz
>> outputs of mfd-s2mps11 with common clock framework.
>>
>> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
>
> Yadwinder,
>
> Looks good to me with the exception of a binding description document.
> Can you provide one and squash it into this commit?
>

Binding description is provided in next patch :
[PATCH 2/3] mfd: sec: Add clock cell for s2mps11  :
https://lkml.org/lkml/2013/7/16/228

Since its a MFD, so i preferred to add documentation in same file
under mfd, same was done for regulators also.
If its fine with you then, I think that patch can go through MFD tree
as same file is touched in for-next of MFD tree.


Thanks,
Yadwinder
