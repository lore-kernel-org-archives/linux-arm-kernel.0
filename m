From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 09:42:55 +0100
Subject: [PATCH] drivers: gpio: Use devm_ioremap_resource function
In-Reply-To: <CAK9yfHw8df1ktZNYx=998_KmbvUt-be8vGo=kSC52DsEF5utAw@mail.gmail.com>
References: <1363253249-3128-1-git-send-email-gheorghiuandru@gmail.com>
 <CAK9yfHw8df1ktZNYx=998_KmbvUt-be8vGo=kSC52DsEF5utAw@mail.gmail.com>
Message-ID: <CACRpkdY1xBTHQsJ2Grru0gw0URXUiBy1XmnFDXPPRbR5xNJtTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 10:34 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> On 14 March 2013 14:57, Alexandru Gheorghiu <gheorghiuandru@gmail.com> wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error
>> handling.
>>
>> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
>
> Similar patch has already been submitted:
> https://lkml.org/lkml/2013/3/4/124

I've applied the earlier patch.

Yours,
Linus Walleij
