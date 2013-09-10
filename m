From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Sep 2013 09:51:14 -0700
Subject: [PATCH 07/38] ARM: ux500: CONFIG: Enable ST's IIO Accelerometer
 Sensors by default
In-Reply-To: <20130910153543.GB11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMj+YzkE5bAxUqFYWoJ-RURDdCK5MUWYTc+gWFQMB3KWkg@mail.gmail.com>
 <20130910153543.GB11227@lee--X1>
Message-ID: <CAOesGMhSLnSeJ29zYf0kjxDWEtN5gwmumOgJFKUruYACaB9Dzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 8:35 AM, Lee Jones <lee.jones@linaro.org> wrote:

>> splitting this and the other config update into two patches? Really?
>
> I haven't split anything. I created the patches as I was
> enabling/testing the drivers, which was at completely different
> times. The only reason they're close together in the set is because I
> reorganised it and didn't think it was necessary to squash them
> together.

In this case, squashing makes a lot of sense. But you could even have
LinusW do that for you when he pulls in the various config updates for
next release.


-Olof
