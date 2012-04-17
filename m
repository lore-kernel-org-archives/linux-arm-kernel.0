From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 17 Apr 2012 16:05:29 +0530
Subject: [PATCH] mmc: omap_hsmmc: Fix check for mmc dt node
In-Reply-To: <4F8D41E7.2050701@ti.com>
References: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
 <4F8D41E7.2050701@ti.com>
Message-ID: <CAJe_ZhcTedCeNW=Tq=ftf13+9daOgVfPZJ4DLu9_qOYXXo7jEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 15:41, Rajendra Nayak <rnayak@ti.com> wrote:
> On Tuesday 17 April 2012 03:24 PM, Jassi Brar wrote:
>>
>> Proper check should be if the hsmmc driver got its platform_data
>> via devicetree, and not if the devicetree is populated for the
>> platform.
>
> This one is already fixed here..
> http://www.spinics.net/lists/linux-omap/msg67879.html
>
Your patch looks better.

-j
