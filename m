From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 14 Mar 2013 15:04:26 +0530
Subject: [PATCH] drivers: gpio: Use devm_ioremap_resource function
In-Reply-To: <1363253249-3128-1-git-send-email-gheorghiuandru@gmail.com>
References: <1363253249-3128-1-git-send-email-gheorghiuandru@gmail.com>
Message-ID: <CAK9yfHw8df1ktZNYx=998_KmbvUt-be8vGo=kSC52DsEF5utAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2013 14:57, Alexandru Gheorghiu <gheorghiuandru@gmail.com> wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error
> handling.
>
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>

Similar patch has already been submitted:
https://lkml.org/lkml/2013/3/4/124
