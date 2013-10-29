From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Oct 2013 12:44:51 -0700
Subject: [GIT PULL]ARM: sirf: dts update for 3.13
In-Reply-To: <CAGsJ_4z0xLZE5yfaQqVnVne8zn=D13UxmWb8P6pknPNcQ9p14A@mail.gmail.com>
References: <CAGsJ_4z0xLZE5yfaQqVnVne8zn=D13UxmWb8P6pknPNcQ9p14A@mail.gmail.com>
Message-ID: <20131029194451.GA19870@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

On Wed, Oct 30, 2013 at 02:49:09AM +0800, Barry Song wrote:
> Hi Oolf,
> 
> as discussed at "[GIT PULL]ARM: sirf: dts fixes for 3.12-rc"
> http://www.spinics.net/lists/arm-kernel/msg276335.html
> 
> some CSR SiRFSoC dts changes are queued for 3.13 here.
> 
> -barry
> 
> The following changes since commit 959f58544b7f20c92d5eb43d1232c96c15c01bfb:
> 
>   Linux 3.12-rc7 (2013-10-27 16:12:03 -0700)

There's really no need to base this branch on -rc7, please go with older
-rc bases unless there's a good reason to pick up a newer one (such as
to avoid conflicts with bugfixes).

> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/sirf-dts-for-3.13
> 
> for you to fetch changes up to 6b4e51e09de47c9d7fe3eccde339e1e61001bce3:
> 
>   ARM: dts: sirf: add missed address-cells and size-cells for prima2
> I2C (2013-10-30 02:31:51 +0800)

I've taken the patches from this branch and applied them to a 3.12-rc4-based
branch and merged them in. So they are now in next/dt, but the same commit ids
are not. Since there's no sirf tree in linux-next this should hopefully not
cause any problems.

No further action needed on your part. :)


-Olof
