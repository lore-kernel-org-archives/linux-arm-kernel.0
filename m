From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 May 2013 16:49:58 -0700
Subject: [PATCH] ARM: EXYNOS5: Fix kernel dump in AFTR idle mode
In-Reply-To: <044a01ce4d0d$6bf36570$43da3050$%kim@samsung.com>
References: <1367235107-31328-1-git-send-email-inderpal.singh@linaro.org>
 <20130509202208.GA21831@quad.lixom.net>
 <044a01ce4d0d$6bf36570$43da3050$%kim@samsung.com>
Message-ID: <CAOesGMi0KnkXt0ihWtvVXpWiAq7WvySDC6Rg0=4PTs8d5tTxig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 4:32 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Olof Johansson wrote:
>>
>> On Mon, Apr 29, 2013 at 05:01:47PM +0530, Inderpal Singh wrote:
>> > The kernel crashes while resuming from AFTR idle mode. It happens
>> > because L2 cache was not going into retention state.
>> >
>> > This patch configures the USE_RETENTION bit of ARM_L2_OPTION register
>> > so that it does not depend on MANUAL_L2RSTDISABLE_CONTROL of
>> > ARM_COMMON_OPTION register for L2RSTDISABLE signal.
>> >
>> > Signed-off-by: Inderpal Singh <inderpal.singh@linaro.org>
>>
>> I haven't seen any activity from Kgene on this, but it seems reasonably
>> bad
>
> I spent time with my family last week...
>
>> (and the fix is self-contained). Applying to arm-soc fixes branch.
>>
> Anyway, thanks.

No worries. :)


-Olof
