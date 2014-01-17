From: pekon@ti.com (Gupta, Pekon)
Date: Fri, 17 Jan 2014 17:40:09 +0000
Subject: [PATCH v4 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <CAD6G_RT1m+7BWZyYqU7Pb2+bhki-Wqs6f96=GhMyF1nHyy2wuw@mail.gmail.com>
References: <1387950629-27448-1-git-send-email-b32955@freescale.com>
 <CAD6G_RTnNQgeJM8Tc16Sc1_n29d=V9sJN1ePrOAn5YzM+GujMQ@mail.gmail.com>
 <52D7A237.8@freescale.com>
 <CAD6G_RRNg-uRtKnnVgJYpUGPsKecAUm9mwETVJsCsaGSuL2eCw@mail.gmail.com>
 <20140117020226.GB27652@shlinux2.ap.freescale.net>
 <CAD6G_RR7vgmHGFj4GqwCYLQQO6tbsZAeCzVBivbcxnCGSwgiWQ@mail.gmail.com>
 <20140117065401.GA6140@shlinux2.ap.freescale.net>
 <CAD6G_RSF_TPk8g9CNmSc+xs+9psLmJoakZw3Eqf-a8KD5P4AVg@mail.gmail.com>
 <CAD6G_RT1m+7BWZyYqU7Pb2+bhki-Wqs6f96=GhMyF1nHyy2wuw@mail.gmail.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA664C6@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shijie,

>From: Jagan Teki [mailto:jagannadh.teki at gmail.com]
[...]
>
>I feel these are good points to discuss all.
>1. With new framework seems like we need two separate controller drivers
>    one for non spi-nor and one for spi-nor with single controller hw
>2. With spi-nor implementation though the hw is spi complaint but the sw is
>   completely ignoring the Linux SPI core interaction.
>
>I feel above two points are technically wrong - Please correct me if am wrong
>but need all developers will join..thanks!
>
I have been following this patch-set from sometime, And I think point (2)
has been discussed back and forth in multiple times in earlier discussions.
So, Is it possible for you to summarize point (2) with all pros-n-cons ?

- A README will helpful to clear all doubts and will ease your implementation
  as well.
- It will also help in reducing turn-around time to get this framework in
   acceptable state and still keep it generic enough.

You can submit the README as Documentation/mtd/spi-nor.txt


with regards, pekon
