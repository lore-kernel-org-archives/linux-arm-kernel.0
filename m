From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Jun 2013 14:20:34 +0200
Subject: [PATCH 4/7] of: introduce of_parse_phandle_with_fixed_args
In-Reply-To: <51C4D75C.9060007@wwwdotorg.org>
References: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
 <1371157199-7272-4-git-send-email-swarren@wwwdotorg.org>
 <51C4D75C.9060007@wwwdotorg.org>
Message-ID: <CACRpkda5U0efRNL+e2+mCKe8MEAdiCDTc8iB4v-i37244ZUsOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 12:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/13/2013 02:59 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This is identical to of_parse_phandle_with_args(), except that the
>> number of argument cells is fixed, rather than being parsed out of the
>> node referenced by each phandle.
>
> Rob, Grant, are you OK with these two DT patches? LinusW would like an
> ack so he can take the series, which implements gpio-ranges property
> parsing cleanup, through the GPIO tree. Thanks.

Yeah ping on this, it's a real nice cleanup.

Yours,
Linus Walleij
