From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 17:38:36 +0200
Subject: [GIT PULL] meson: basic support for MesonX SoCs
In-Reply-To: <20140923195221.GA30267@nuc>
References: <20140923195221.GA30267@nuc>
Message-ID: <3795274.gkYSyS04CD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 21:52:21 Carlo Caione wrote:
> Hi Arnd and Olof,
> 
> Here the pull request to introduce preliminary support for MesonX SoCs.
> It is based on the patchset at:
> 
> http://www.spinics.net/lists/arm-kernel/msg362521.html
> 
> and it is based on the master of arm-soc tree.
> 

Hi Carlo,

I ended up cherry-picking the individual changes into next/fixes-non-critical,
next/defconfig, next/dt and next/soc to fit our process better.

In general, please split up pull requests according to the next/* topic
branches we have in the arm-soc tree, as documented in 
arch/arm/arm-soc-for-next-contents.txt (only in the for-next branch).

More importantly, please base all changes on the most recent -rc1 release,
or possibly a later -rc if you get conflicts otherwise.

I know the process takes a little time to get used to ;-)

	Arnd
