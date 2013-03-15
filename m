From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 10:28:03 +0000
Subject: [GIT PULL][for 3.9] pull request from fix branch in pxa git tree
In-Reply-To: <CAN1soZzTVtg0HJFDiOFMfMngqz0yNs6Le+hvuNUxQ=Ka9dUaHQ@mail.gmail.com>
References: <CAN1soZzTVtg0HJFDiOFMfMngqz0yNs6Le+hvuNUxQ=Ka9dUaHQ@mail.gmail.com>
Message-ID: <201303151028.03796.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Haojian Zhuang wrote:
> are available in the git repository at:
> 
>   git://github.com/hzhuang1/linux.git armsoc/fix
> 

Pulled into fixes branch.

> for you to fetch changes up to e71dc5f787f3908b8b8158103fc7d74a78a22cd1:
> 
>   ARM: mmp: add platform_device head file in gplugd (2013-03-15 16:27:53 +0800)
> 
> ----------------------------------------------------------------
> Haojian Zhuang (1):
>       ARM: mmp: add platform_device head file in gplugd

I did not see that problem with my usual defconfig builds. Can you submit
a patch for 3.10 that will enable all mmp boards in pxa168_defconfig
or pxa910_defconfig?

In particular, the lack of the DT based configurations in the defconfig
files should be fixed.

	Arnd
