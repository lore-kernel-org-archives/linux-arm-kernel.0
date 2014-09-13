From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 13 Sep 2014 13:34:33 +0200
Subject: [PATCH 0/4] Add initial support for pinctrl on Exynos7
In-Reply-To: <1410598252-30931-1-git-send-email-a.kesavan@samsung.com>
References: <1410598252-30931-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <54142BC9.9050303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On 13.09.2014 10:50, Abhilash Kesavan wrote:
> The following patches are tested based on Kgene's for-next tree.
> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
> 
> Following patches are required for this series:
> 1- "tty/serial: fix config dependencies for samsung serial"
>    https://www.mail-archive.com/linux-samsung-soc <at> vger.kernel.org/msg36208.html
> 2- "dts, kbuild: Implement support for dtb vendor subdirs" patchset 
>    http://comments.gmane.org/gmane.linux.kbuild.devel/12131
> 3- "arch: arm64: enable support for Samsung Exynos7 SoC" patchset
>    http://www.spinics.net/lists/linux-samsung-soc/msg36728.html
> 

Other than few of my and Thomas's comments, my further actions (i.e. an
ACK) will depend on reply to [1].

[1] http://thread.gmane.org/gmane.linux.kernel.samsung-soc/36823/focus=37456

Best regards,
Tomasz
