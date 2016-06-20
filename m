From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 08:30:21 -0700
Subject: [GIT PULL 5/7] Broadcom maintainers changes for 4.8 Part 1
In-Reply-To: <3965618.mynEkqfry0@wuerfel>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
 <20160620055143.GH2329@localhost>
 <CACna6rxXQuU7MqFomqK8tUoyFgiH-nC-M9UEyvKk1rXs8yS64A@mail.gmail.com>
 <3965618.mynEkqfry0@wuerfel>
Message-ID: <CAOesGMgAM3MW0ha07HNbBz-QsXwWU=GU8pd6L-HdZ2gJ0Gp4Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 12:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, June 20, 2016 9:35:53 AM CEST Rafa? Mi?ecki wrote:
>>
>> I was asked by Florian to add bcm-kernel-feedback-list@ but indeed he
>> didn't specify if this should be L: entry.
>> [21:24:43] <[florian]> rmilecki: also submit a patch that includes
>> bcm-kernel-feedback-list at broadcom.com in the MAINTAINERS file for
>> BCM5310X
>> [21:36:51] <rmilecki> [florian]: I wasn't sure if I'm supposed to do that
>> [21:36:53] <rmilecki> i can try I guess
>>
>> I'm afraid this mailing list is closed. Would M: entry work for it?
>
>
> I think M: is better, we have a couple of examples like that (x86 at kernel.org,
> Dept-GELinuxNICDev at qlogic.com, linux-wimax at intel.com, ...).

Yep, having it as a M: entry would be fine with me as well. Please
respin the patch/branch -- we can apply a patch directly instead of
doing a merge if that's easier for you.


-Olof
