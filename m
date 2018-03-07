From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:51:36 +0100
Subject: [GIT PULL] tee driver misc for v4.17
In-Reply-To: <CAHUa44HqoQ2yxBzJsQQxb35h=S4suDB7qpoQXwsBhx_OXHyBMw@mail.gmail.com>
References: <CAHUa44HqoQ2yxBzJsQQxb35h=S4suDB7qpoQXwsBhx_OXHyBMw@mail.gmail.com>
Message-ID: <CAK8P3a3aHbXOB+pHRi44D7e=Gc1yX_Dtb_LvYguJhinRa+vG+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 12:22 PM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Small fix and report OP-TEE revision information
>
> * Adds one small fix correct max value of privileged device id allocation,
>   this is only needed if there's more than TEE_NUM_DEVICES / 2 (16) tee
>   drivers registered. One or two is a normal value.
> * Reports OP-TEE revision information (major, minro version and build id
>   if available)

Pulled into next/drivers, thanks!

        Arnd
