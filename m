From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 15 Jul 2012 13:14:44 +0300
Subject: [PATCH] remoteproc: adopt the driver core's alloc/add/del/put
 naming
In-Reply-To: <4FF50107.8030406@codeaurora.org>
References: <1341409019-32166-1-git-send-email-ohad@wizery.com>
 <4FF50107.8030406@codeaurora.org>
Message-ID: <CAK=WgbbO72S9=T-dnJBHE5d5k9H8dtYFtxe_AMSe+ut+0ZPOHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 5:50 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 7/4/2012 6:36 AM, Ohad Ben-Cohen wrote:
>> To make remoteproc's API more intuitive for developers, we adopt
>> the driver core's naming, i.e. alloc -> add -> del -> put. We'll also
>> add register/unregister when their first user shows up.
>>
>> Otherwise - there's no functional change here.
>>
>> Suggested by Russell King <linux@arm.linux.org.uk>.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

On Thu, Jul 5, 2012 at 2:50 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> I understand this patch and it's a good thing, so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Thanks Linus and Stephen.

Applied.
