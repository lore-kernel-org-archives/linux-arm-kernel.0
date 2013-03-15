From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 15 Mar 2013 18:37:36 +0800
Subject: [GIT PULL][for 3.9] pull request from fix branch in pxa git tree
In-Reply-To: <201303151028.03796.arnd@arndb.de>
References: <CAN1soZzTVtg0HJFDiOFMfMngqz0yNs6Le+hvuNUxQ=Ka9dUaHQ@mail.gmail.com>
 <201303151028.03796.arnd@arndb.de>
Message-ID: <CAN1soZwUjOLTkp1fWz2OmM2EhF=yET81hBitfN8rvC=JQsZ1iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 6:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 March 2013, Haojian Zhuang wrote:
>> are available in the git repository at:
>>
>>   git://github.com/hzhuang1/linux.git armsoc/fix
>>
>
> Pulled into fixes branch.
>
>> for you to fetch changes up to e71dc5f787f3908b8b8158103fc7d74a78a22cd1:
>>
>>   ARM: mmp: add platform_device head file in gplugd (2013-03-15 16:27:53 +0800)
>>
>> ----------------------------------------------------------------
>> Haojian Zhuang (1):
>>       ARM: mmp: add platform_device head file in gplugd
>
> I did not see that problem with my usual defconfig builds. Can you submit
> a patch for 3.10 that will enable all mmp boards in pxa168_defconfig
> or pxa910_defconfig?
>
> In particular, the lack of the DT based configurations in the defconfig
> files should be fixed.
>
>         Arnd

Sure. I'll enable them in defconfig.

Regards
Haojian
