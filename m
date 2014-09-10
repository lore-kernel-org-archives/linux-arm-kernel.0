From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Sep 2014 22:33:00 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Configure the pins locally
In-Reply-To: <20140910013048.GC2341@dragon>
References: <1409921170-23935-1-git-send-email-festevam@gmail.com>
 <20140910013048.GC2341@dragon>
Message-ID: <CAOMZO5A5or4M6u3GkOcQ2ZLUL=HLd79bQwrJCAyMYjFaTvjtTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 10:30 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

> Just to ensure I get it right, you verified the setting for all those
> pins by inspecting a running kernel, right?

That's correct.

I verified manually reading the IOMUXC_SW_PAD_CTL values for all the
pins from a running kernel.
