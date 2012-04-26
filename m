From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Apr 2012 11:04:33 +0800
Subject: imx sgtl5000:BUG: scheduling while atomic:
 speaker-test/1225/0x00000003
In-Reply-To: <CAOMZO5BeGRgxPeyxYNDD+OcZWCMekf5LpouLCLuwco=f7WRahg@mail.gmail.com>
References: <20120426023319.GC28063@b20223-02.ap.freescale.net>
 <CAOMZO5BeGRgxPeyxYNDD+OcZWCMekf5LpouLCLuwco=f7WRahg@mail.gmail.com>
Message-ID: <20120426030432.GE28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 12:00:27AM -0300, Fabio Estevam wrote:
> On Wed, Apr 25, 2012 at 11:33 PM, Richard Zhao
> <richard.zhao@freescale.com> wrote:
> 
> > kernel: 3.4rc3 with ASoC/for-next and some my patches.
> 
> Which board is this? Does it work on a mx51babbage?
I'm adding imx6q_sabrelite audio support. But the dump don't
have a clue that's board specific, so I put it here to see
whether anyone else ever saw the similar.

I didn't try mx5.

Thanks
Richard
