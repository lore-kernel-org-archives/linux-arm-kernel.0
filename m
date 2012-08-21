From: ccross@android.com (Colin Cross)
Date: Tue, 21 Aug 2012 13:31:58 -0700
Subject: [PATCH 1/4] ARM: clps711x: Remove board support for CEIVA
In-Reply-To: <201208211950.07166.arnd@arndb.de>
References: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
 <201208211950.07166.arnd@arndb.de>
Message-ID: <CAMbhsRReOzQogzESWjKu5o=0Ep3UqcEP1zdzO8dbHfM4AofhYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 12:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 August 2012, Alexander Shiyan wrote:
>> The current kernel does not fit in the CEIVA ROM. Also, some functional
>> has already been removed due migrate from 2.6 to 3.0, and it seems that
>> no one uses this platform. So, remove support for this board and modules
>> specific only to this board.
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>
> I got curious about this machine and found some ten year old emails
> and a howto from Colin Cross about this machine. Since he's still
> actively working on ARM Linux, maybe he has some final words to say
> about this platform before it gets removed.
>
> Otherwise, no objections.

That was my first embedded linux hobby project, and I haven't touched
it in ten years, although I probably have one in a box somewhere.  I
have no objection to removing it.
