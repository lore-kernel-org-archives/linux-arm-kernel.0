From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Apr 2014 11:44:07 +0800
Subject: [PATCH 2/3] ARM: dts: imx27-pdk: Pass the UART1 pin configuration
In-Reply-To: <CAOMZO5DfoxjbFYW8q1S4jiQ4rmDwa5-9-5stf=hL5nzcK+9=Gw@mail.gmail.com>
References: <1396477546-11130-1-git-send-email-festevam@gmail.com>
 <1396477546-11130-2-git-send-email-festevam@gmail.com>
 <20140403020137.GC2786@dragon>
 <CAOMZO5DfoxjbFYW8q1S4jiQ4rmDwa5-9-5stf=hL5nzcK+9=Gw@mail.gmail.com>
Message-ID: <20140409034405.GC2611@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 12:37:27AM -0300, Fabio Estevam wrote:
> On Wed, Apr 2, 2014 at 11:01 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> > The iomuxc node in board dts is a little special now, and it will have a
> > lot more data than others.  I like Alexander's idea to put it at the
> > bottom of the file to make it easier for users to check board level
> > settings of other device nodes.  So I would suggest that way for the new
> > added iomuxc node in board dts.
> 
> Could you please point me Alexander's patch for reference? I was not
> able to locate it.

http://www.spinics.net/lists/arm-kernel/msg318968.html

Shawn
