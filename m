From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Aug 2012 10:17:04 -0700
Subject: [GIT PULL][for 3.6] pull request from board branch in pxa git tree
In-Reply-To: <20120802171149.GA26795@quad.lixom.net>
References: <CAN1soZxxZMy7iVx=r1XwaxfXVLAXBGd03t5rv7PM4A7dQm_HFA@mail.gmail.com>
 <20120802171149.GA26795@quad.lixom.net>
Message-ID: <CAOesGMhmCveAjGnbMic7HgW4CX_L4g+2tmmOP3UPEF=NwtfxXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2012 at 10:11 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, Jul 31, 2012 at 09:39:55AM +0800, Haojian Zhuang wrote:
>> Hi Arnd & Olof,
>>
>> Please help to pull these from board branch of pxa git tree for v3.6
>>
>> Regards
>> Haojian
>>
>> The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:
>>
>>   Linux 3.5 (2012-07-21 13:58:29 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/hzhuang1/linux.git board
>>
>
> I'm not sure what to think of this branch. It contains one bugfix
> (missing include) and one feature.
>
> All features for a merge window should be in our tree by the time the
> merge window opens.
>
> I've pulled it in this time, but please don't send features this late
> again -- queue them up for the next merge window instead.


Actually, on second throught (since I also noticed the second pull
request after sending this reply), I cherry-picked the IRQ fix out of
the branch instead. Please include the board platform_device change in
your branches for 3.7 instead.


-Olof
