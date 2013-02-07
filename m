From: cjb@laptop.org (Chris Ball)
Date: Wed, 06 Feb 2013 21:35:46 -0500
Subject: [GIT PULL] ux500 DT related fixes and platform enhancements
In-Reply-To: <CACRpkdZ-Z2y6djnQsBZ0tY+zAuX7E1v=+TvF1CYc0CZc8QnWWQ@mail.gmail.com>
 (Linus Walleij's message of "Wed, 6 Feb 2013 23:28:01 +0100")
References: <20130131115552.GG5301@gmail.com> <20130206135911.GB7519@gmail.com>
 <CAOesGMiJTcjdEJzSDkpdV-ZCqN24uVmfjM-HOt+ojErS=98TmQ@mail.gmail.com>
 <CACRpkdZ-Z2y6djnQsBZ0tY+zAuX7E1v=+TvF1CYc0CZc8QnWWQ@mail.gmail.com>
Message-ID: <874nhoetq5.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 06 2013, Linus Walleij wrote:
> On Wed, Feb 6, 2013 at 6:48 PM, Olof Johansson <olof@lixom.net> wrote:
>
>>>       mmc: mmci: Move ios_handler functionality into the driver
>>
>> This patch lacks acks from MMC maintainers. Actually, it should just
>> be submitted like any other MMC patches; to Chris Ball and the MMC
>> list.
>
> Actually this one driver usually goes through Russell's tree.
> He was OK with Lee pushing it this way, although I don't know if
> he got a formal ACK?
>
> It doesn't hurt to have Chris' ACK on it too though.

Yeah, I've been pointing MMCI patches towards Russell's patch tracker,
but taking everything else through mmc-next.  Sorry for having a
confusing policy.  In this case the patch went into Russell's
tracker and then came back out again for ordering reasons.

Since Russell's happy with it:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
