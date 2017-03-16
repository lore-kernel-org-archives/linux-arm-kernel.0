From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Mar 2017 10:59:55 +0100
Subject: mainline build: 208 builds: 0 failed, 208 passed,
 422 warnings (v4.11-rc2-164-gdefc7d752265)
In-Reply-To: <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
References: <58c97f8f.c4b5190a.8c4e4.300d@mx.google.com>
 <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
Message-ID: <CAK8P3a145sL=DHiyP39c2FrH9Vh9aZBd7GUs96pWd-93NngQDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 9:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Mar 15, 2017 at 6:53 PM, kernelci.org bot <bot@kernelci.org> wrote:
>>
>> mainline build: 208 builds: 0 failed, 208 passed, 422 warnings (v4.11-rc2-164-gdefc7d752265)
>
> The last build failure in mainline is gone now, though I don't know
> what fixed it.
> Let's hope this doesn't come back as the cause was apparently a race condition
> in Kbuild that might have stopped triggering.

Now the failure in x86_64 allmodconfig+CONFIG_OF=n is back, which makes it
particularly hard to bisect as the problem only shows up sometimes.

     Arnd
