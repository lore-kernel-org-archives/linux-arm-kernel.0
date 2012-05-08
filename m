From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 8 May 2012 11:43:39 +0530
Subject: [PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function.
In-Reply-To: <alpine.DEB.2.00.1205072314480.9984@utopia.booyaka.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-8-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1205072314480.9984@utopia.booyaka.com>
Message-ID: <CAMQu2gxeqbpO71xmTF3VLABC69kK19vhquakHfqHSVPf1zhTLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2012 at 10:45 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 2 May 2012, Santosh Shilimkar wrote:
>
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> Instead of statically defining seperate arrays for every OMAP4+ archs,
>> have a generic init function to populate the arrays. This avoids the
>> need for creating new array for every arch added in the future that
>> reuses the prm and cm registers read/write code.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Thanks, looks reasonable, will queue this for 3.5.
>
Great. I will drop this one from my clean-up pull request.

Regards
Santosh
