From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jun 2011 09:00:27 +0200
Subject: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
In-Reply-To: <BANLkTimkk3JfuVmhuBAw4Op93oDtjKdoXw@mail.gmail.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
	<FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
	<BANLkTimkk3JfuVmhuBAw4Op93oDtjKdoXw@mail.gmail.com>
Message-ID: <201106070900.27637.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 June 2011 07:44:42 zhangfei gao wrote:
> On Sat, Jun 4, 2011 at 5:08 AM, Philip Rakity <prakity@marvell.com> wrote:
> >
> > Please update mmp2 and pxa defconfigs.
> 
> The trend is replacing defconfig with device tree, it may not
> acceptable to update defconfig.

Actually, the defconfigs are not going away, at least not directly.

The device tree will replace the need for individual board files,
but not for defconfig files. As a side-effect, the number of
defconfig files can get reduced, but we should still maintain
them.

	Arnd
