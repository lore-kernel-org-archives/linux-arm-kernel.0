From: horms@verge.net.au (Simon Horman)
Date: Fri, 24 Aug 2018 10:23:28 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77965: Add OPPs table for
 cpu devices
In-Reply-To: <20180822144113.s7prdezkj5c3xjqm@verge.net.au>
References: <1534255961-23326-1-git-send-email-ykaneko0929@gmail.com>
 <20180822144113.s7prdezkj5c3xjqm@verge.net.au>
Message-ID: <20180824082327.5my3j4zujckqbe65@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 04:41:18PM +0200, Simon Horman wrote:
> On Tue, Aug 14, 2018 at 11:12:41PM +0900, Yoshihiro Kaneko wrote:
> > From: Dien Pham <dien.pham.ry@renesas.com>
> > 
> > This patch adds OPPs table for CA57{0,1} cpu devices
> > 
> > Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Tested on r8a77965/Salvator-XS
> 
> I see that CPUFreq is activated, that sysfs reports 3 possible
> CPU speeds; 1.5, 1.0 and 0.50GHz. That current CPU frequency can be manipulated
> by setting the maximum CPU frequency in sysfs. And that the frequency
> of Z clock changes accordingly.
> 
> Tested-by: Simon Horman <horms+renesas@verge.net.au>

I have applied this for v4.20.
