From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 15:23:33 -0800
Subject: [PATCH V3 2/2] ARM: multi_v7_defconfig: add mvebu drivers
In-Reply-To: <8a95aff6b85c8974e3e5cfea0b0765b3a9bedc80.1390936638.git.jason@lakedaemon.net>
References: <9609875ac4d1bd7d628bd994e0646340d78e423d.1390936638.git.jason@lakedaemon.net>
 <8a95aff6b85c8974e3e5cfea0b0765b3a9bedc80.1390936638.git.jason@lakedaemon.net>
Message-ID: <20140131232333.GD11138@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 07:27:15PM +0000, Jason Cooper wrote:
> Recent boot farm testing has highlighted some issues with mvebu and
> multiplatform kernels.  Increase the test coverage so we can discover
> these issues earlier.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> v2 -> v3:
>  - rebase onto arm-soc/for-next so arm-soc can apply directly for v3.14-rcX
> 
> v1 -> v2:
>  - split into two patches, update and +mvebu
> 
>  arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied. I ended up redoing the 1/2 patch myself but this one is applied as-is
with minor fixup.


-Olof
