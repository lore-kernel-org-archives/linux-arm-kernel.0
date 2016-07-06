From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 21:49:19 -0700
Subject: [GIT PULL] arm64: dts: hisilicon: hi6220 hikey board updates for
 4.8
In-Reply-To: <5772B8AF.4040608@hisilicon.com>
References: <5772B8AF.4040608@hisilicon.com>
Message-ID: <20160706044919.GI23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 06:49:35PM +0100, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hi6220-dt-for-4.8
> 
> for you to fetch changes up to bbaf867e2d3796bca465d07ffcd800a3bd570861:
> 
>   arm64: dts: hikey: name the GPIO lines (2016-06-28 17:36:04 +0100)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon Hi6220 hikey board updates for 4.8
> 
> - name the GPIO lines
> 
> ----------------------------------------------------------------
> Linus Walleij (1):
>       arm64: dts: hikey: name the GPIO lines
> 
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)

Merged into next/dt64. Thanks.

Also, as I've told others: If you redirect your git request-pull to a file, or
pipe it through cat, it'll produce a diffstat that is more reasonable for email
(80 columns).


-Olof
