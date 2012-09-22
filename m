From: olof@lixom.net (Olof Johansson)
Date: Sat, 22 Sep 2012 00:45:47 -0700
Subject: Status of arm-soc for 3.7
In-Reply-To: <CAOesGMjWcEXubD9ei+r=Xxz9KdJcFMsuk0pEN08nNsas8we3_A@mail.gmail.com>
References: <CAOesGMjWcEXubD9ei+r=Xxz9KdJcFMsuk0pEN08nNsas8we3_A@mail.gmail.com>
Message-ID: <CAOesGMivmSRpj1q29jBL6DM3YCa75tzguuTu_xZ9MzDvHvkHGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quick update:

On Thu, Sep 20, 2012 at 11:21 PM, Olof Johansson <olof@lixom.net> wrote:

> What's left to deal with is:
>
> * smp_ops branch, since multiplatform depends on it to allow building
> more than one platform.

smp_ops and platform_data have both been merged into
next/multiplatform now, and I have been successful at building a
kernel that includes all current multiplatform-enabled platforms.


-Olof
