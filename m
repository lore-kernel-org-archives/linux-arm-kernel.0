From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 25 Jan 2016 20:55:16 +0600
Subject: [PATCH 1/3] printk: make preferred_console local static bool
In-Reply-To: <CAHp75Ve+7N+7CCNNQDBBzOZWY-iuVz=9q8vp5TYQhABM2M3cwg@mail.gmail.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75Ve+7N+7CCNNQDBBzOZWY-iuVz=9q8vp5TYQhABM2M3cwg@mail.gmail.com>
Message-ID: <56A63754.7030108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25.01.2016 20:24, Andy Shevchenko wrote:
> On Mon, Jan 25, 2016 at 1:45 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> The variable preferred_console is used only inside register_console()
>> and it's semantics is boolean.  Make it clear.
>
> However the patch looks okay it brings imbalance to understanding how
> exactly the preferred console is chosen.

On the contrary, I would say it makes things more clear.

Also please consider this patch preparatory for the further changes.
See my replies to Joe Perches.
