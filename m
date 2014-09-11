From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 11 Sep 2014 16:51:09 +0200
Subject: [PATCH v2 2/4] arm64, thunder: Add initial dts for Cavium
 Thunder SoC
In-Reply-To: <5017180.kZRPNE71Sv@wuerfel>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <1409903205-2762-3-git-send-email-rric@kernel.org>
 <5017180.kZRPNE71Sv@wuerfel>
Message-ID: <20140911145109.GJ10622@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 05.09.14 13:21:48, Arnd Bergmann wrote:
> On Friday 05 September 2014 09:46:43 Robert Richter wrote:
> > diff --git a/arch/arm64/boot/dts/thunder-88xx.dts b/arch/arm64/boot/dts/thunder-88xx.dts
> > new file mode 100644
> > index 000000000000..4cc1d059d2d9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/thunder-88xx.dts
> 
> Most people end up having a soc.dtsi file and a board.dsi file including
> the former and adding the machine-specific properties.

thanks for your feedback on the dts file. I already included your
suggestion into the patches and split the files.

-Robert
