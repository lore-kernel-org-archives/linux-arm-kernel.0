From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 13:53:52 +0800
Subject: [PATCH v3 4/4] ARM: dts: add initial MVF600 Tower board dts
 support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CB26E@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-5-git-send-email-b35083@freescale.com>
 <20130519152932.GA24301@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851CB26E@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20130520055350.GF25113@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 05:01:47AM +0000, Lu Jingchang-B35083 wrote:
> [Lu Jingchang-B35083] 
>  Sound, I2C, QuadSPI and SAI added in the initial dts have been test locally on the mainline kernel, and the patches will be sent to maillist later. Thanks!
> 

Please add them after driver patches get accepted by subsystem
maintainers.  If the DT bindings can not be accepted as it is, we will
end up changing the dts files back and forth.

Shawn
