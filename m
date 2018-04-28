From: npcomplete13@gmail.com (Vivek Unune)
Date: Sat, 28 Apr 2018 00:19:36 -0400
Subject: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys
 Panamera
In-Reply-To: <20180427140542.c3t5taztkciimfny@osboxes>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
 <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
 <20180311100313.znonhesgh462rz65@osboxes>
 <2ef6e4fc-cce7-372e-e35f-578fd6ada9ca@gmail.com>
 <20180313010210.ws4dugy3rrpqwzmk@osboxes>
 <00df9ee9-2bd2-ad2b-fdf8-682efdb9a4d1@gmail.com>
 <20180427140542.c3t5taztkciimfny@osboxes>
Message-ID: <CAChtp74P5iXZjtooR5e1PgmNYU7qD07GSyKo9GV-3ObR1zGvHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 10:05 AM, Vivek Unune <npcomplete13@gmail.com> wrote:
> On Wed, Apr 25, 2018 at 11:02:04AM +0200, Rafa? Mi?ecki wrote:
>>
>> The easiest solution: ignore all these "error -74 (ECC error) while
>> reading" errors (they may last for few minutes!). I believe UBI should
>> simply recreate all pages it couldn't access and once you wait long
>> enough, all your NAND flash will be using BCH8.
>
> Let me build the firmware with BCH-8 and wait it out. I'll report back my
> results.

I can confirm that BCH-8 indeed works after letting it run through those
ECC errors.

Thanks!

Vivek
