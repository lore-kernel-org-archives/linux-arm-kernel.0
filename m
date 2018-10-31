From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Oct 2018 22:17:29 +0100
Subject: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
In-Reply-To: <CAHTX3dJTXtuA0i-ffPjoiWuxEcF_5JY55VJtWd9zxW4HxK1K3w@mail.gmail.com>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
 <CAHTX3dJTXtuA0i-ffPjoiWuxEcF_5JY55VJtWd9zxW4HxK1K3w@mail.gmail.com>
Message-ID: <CACRpkdarkLuErC_F4ALqOB5Wuf7TnDXmWZVKvfR7iGvOy=j++g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 4:47 PM Michal Simek <monstr@monstr.eu> wrote:

> No doubt about it that this is good. If this is there from day 1 all will be good.
> I am just saying that we are all the time
> saying that we shouldn't break userspace. Right now if there is single application
> which uses existing names we are breaking it.

Yeah that's the problem, the approach is usually that if a tree falls
in the forest and noone is there to hear it, then it doesn't make a
sound.

But we can't assume someone is there as the safe default either.

I'd say apply it and see what happens, people are supposed to test.

Yours,
Linus Walleij
