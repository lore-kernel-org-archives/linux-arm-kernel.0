From: neidhard.kim@lge.com (Jongsung Kim)
Date: Wed, 24 Aug 2016 19:06:35 +0900
Subject: [PATCH v3 0/4] ARM: kernel: module PLT optimizations
In-Reply-To: <CAKv+Gu-hvgs-73ErCmkj58u5gu18V7JGZLpg400trCyGgNJW1w@mail.gmail.com>
References: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
 <24dd6017-97ad-0051-9a4f-8a76e50076d9@lge.com>
 <CAKv+Gu-hvgs-73ErCmkj58u5gu18V7JGZLpg400trCyGgNJW1w@mail.gmail.com>
Message-ID: <f69b98be-b26f-5df3-4b72-6bd70032adfe@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 08? 23? 20:30, Ard Biesheuvel wrote:
> On 23 August 2016 at 08:06, Jongsung Kim <neidhard.kim@lge.com> wrote: > > Thanks! Could you please confirm that the module still works as expected? >

The platform used in test uses 10+ kernel modules, and the entire system
looks working good with your patchset.

> > Likewise! May I take this as a 'Tested-by: ' ? >

Sure, you may.
