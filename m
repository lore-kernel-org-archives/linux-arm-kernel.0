From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Jan 2013 22:30:16 +0800
Subject: [PATCH 0/9] ARM: PRIMA2: bringup new CSR SiRFmarco SMP SoC
In-Reply-To: <201301141107.53449.arnd@arndb.de>
References: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4wxJR0y1OXEjN1wYY2BTfPXe=WJ7QC8anQMLYuywT5B2A@mail.gmail.com>
 <201301141107.53449.arnd@arndb.de>
Message-ID: <CAGsJ_4z3ngLAFymrrr9k7pOcTrL5NJ6U7TokQ8bwjRX+0C4Jgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Thanks a lot!

2013/1/14 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 06 January 2013, Barry Song wrote:
>> except those from Mark, would you kindly give more feedbacks about
>> this series? after this, i'd like to send out a series about SiRF
>> firmware based on trustzone.
>
> Hi Barry,
>
> Sorry for the late reply. I have looked at the patches and have no
> further comments besides what Mark already mentioned.
>
> Patch 4/9 will unfortunately conflict with the removal of struct sys_timer,
> but we can probably handle that, or you base your patches on top of
> the timer/cleanup branch in arm-soc.

yes. i have read that sys_timer removing patchset recently. i'll
handle the move directly in v2.

>
>         Arnd

-barry
