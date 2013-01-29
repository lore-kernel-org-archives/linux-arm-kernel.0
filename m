From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 09:43:11 -0800
Subject: [GIT PULL v2] imx cleanup for 3.9
In-Reply-To: <20130129064200.GC21504@S2101-09.ap.freescale.net>
References: <20130129064200.GC21504@S2101-09.ap.freescale.net>
Message-ID: <20130129174311.GB17935@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Tue, Jan 29, 2013 at 02:42:02PM +0800, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-cleanup-3.9

Pulled. It had change/remove conflicts due to the removed board files that had
been modified with the timer cleanup which I resolved.

> 
> for you to fetch changes up to 7356420cd34e40fe27bf26555b0bf3f2849a43dd:
> 
>   ARM: imx: Remove mx508 support (2013-01-29 14:05:43 +0800)
> 
> ----------------------------------------------------------------
> I have left out the patch (ARM: dts: imx: use nodes label in board dts)
> in question and other dts related changes, and will have them go via DT
> branch  to save the cross branch dependency.

This is a great message to have in the email, but as a tag description the
previous version of the branch had better contents. So I saved that (and
removed the dt/label reference).


-Olof
