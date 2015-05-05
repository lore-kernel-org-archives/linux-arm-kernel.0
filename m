From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 5 May 2015 22:41:33 +0200
Subject: [PATCH v2 0/2] gpio driver for NXP LPC18xx family
In-Reply-To: <CACRpkdZ9oqsh67-J3imL_tsQxiGfr7O_N82N-SUVmju7cmyb9w@mail.gmail.com>
References: <1430601095-31984-1-git-send-email-manabian@gmail.com>
 <CACRpkdZ9oqsh67-J3imL_tsQxiGfr7O_N82N-SUVmju7cmyb9w@mail.gmail.com>
Message-ID: <CAGhQ9Vy=VQbRrjO7Cd8HQs3gXj6h-t4gG0hZxTO7YB86GKc=Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 5 May 2015 at 17:58, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, May 2, 2015 at 11:11 PM, Joachim Eastwood <manabian@gmail.com> wrote:
>
>> This patch set adds a gpio driver for NXP LPC18xx/43xx devices.
>> Patchset is based on Linus master 4.1-rc1.
>>
>> changes in v2:
>>  - use PBYTE register for gpio set/get
>>  - refactor direction setup
>>  - add lock for direction set RMW cycle
>>  - expand doc example
>
> This v2 version applied.

Excellent.

Thanks Linus.

regards,
Joachim Eastwood
