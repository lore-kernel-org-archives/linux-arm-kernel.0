From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Oct 2017 09:38:47 +0200
Subject: [PATCH 00/11] KASan for arm
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <CAK8P3a3OOMxsr0QM+Uukec4Uq4UxHnUYF6jozxbzwJisd7vOaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 10:22 AM, Abbott Liu <liuwenliang@huawei.com> wrote:
> Hi,all:
>    These patches add arch specific code for kernel address sanitizer
> (see Documentation/kasan.txt).

Nice!

When I build-tested KASAN on x86 and arm64, I ran into a lot of build-time
regressions (mostly warnings but also some errors), so I'd like to give it
a spin in my randconfig tree before this gets merged. Can you point me
to a git URL that I can pull into my testing tree?

I could of course apply the patches from email, but I expect that there
will be updated versions of the series, so it's easier if I can just pull
the latest version.

      Arnd
