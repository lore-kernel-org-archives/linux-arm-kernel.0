From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:03:23 +0100
Subject: [GIT PULL] tee async tee supplicant communication for v4.16
In-Reply-To: <20171129102715.dsxcsq6s5tvnep2s@jax>
References: <20171129102715.dsxcsq6s5tvnep2s@jax>
Message-ID: <CAK8P3a1h=2bWhbRwOHqt1Tw5sLPnop6WNO474JCpxZ7C12XgVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 11:27 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> ----------------------------------------------------------------
> Enable async communication with tee supplicant
>
> This pull request enables asynchronous communication with TEE supplicant
> by introducing meta parameters in the user space API. The meta
> parameters can be used to tag requests with an id that can be matched
> against an asynchronous response as is done here in the OP-TEE driver.
>
> Asynchronous supplicant communication is needed by OP-TEE to implement
> GlobalPlatforms TEE Sockets API Specification v1.0.1. The specification
> is available at https://www.globalplatform.org/specificationsdevice.asp.
>
> This change is backwards compatible allowing older supplicants to work
> with newer kernels and vice versa.
>

Pulled into next/drivers, thanks!

       Arnd
