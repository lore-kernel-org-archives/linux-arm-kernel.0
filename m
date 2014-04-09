From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Apr 2014 00:37:27 -0300
Subject: [PATCH 2/3] ARM: dts: imx27-pdk: Pass the UART1 pin configuration
In-Reply-To: <20140403020137.GC2786@dragon>
References: <1396477546-11130-1-git-send-email-festevam@gmail.com>
 <1396477546-11130-2-git-send-email-festevam@gmail.com>
 <20140403020137.GC2786@dragon>
Message-ID: <CAOMZO5DfoxjbFYW8q1S4jiQ4rmDwa5-9-5stf=hL5nzcK+9=Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 11:01 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

> The iomuxc node in board dts is a little special now, and it will have a
> lot more data than others.  I like Alexander's idea to put it at the
> bottom of the file to make it easier for users to check board level
> settings of other device nodes.  So I would suggest that way for the new
> added iomuxc node in board dts.

Could you please point me Alexander's patch for reference? I was not
able to locate it.
