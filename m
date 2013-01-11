From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 11:12:18 -0800
Subject: [GIT PULL] imx uncompress debug for 3.9
In-Reply-To: <20130110125547.GB8680@S2101-09.ap.freescale.net>
References: <20130110125547.GB8680@S2101-09.ap.freescale.net>
Message-ID: <20130111191218.GA1148@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 10, 2013 at 08:55:50PM +0800, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-uncompress-3.9
> 
> for you to fetch changes up to 0edbac9d72158b443368d7002db387463fe08ffd:
> 
>   ARM: uncompress: support uncompress debug for multiplatform build (2012-12-22 21:01:50 +0800)
> 
> ----------------------------------------------------------------
> I did not get any comment on the series, so would think it's an
> acceptable solution for multiplatform build to get uncompress debug
> capability back.
> 
> ----------------------------------------------------------------
> Shawn Guo (4):
>       ARM: imx: use separated debug uart symbol for imx31 and imx35
>       ARM: imx: support DEBUG_LL uart port selection for all i.MX SoCs
>       ARM: imx: restore uncompress.h to a common place
>       ARM: uncompress: support uncompress debug for multiplatform build

See my comment on the last patch. I would prefer to see a generic solution
instead of having to add a debug/uncompress/ file for every platform.


-Olof
