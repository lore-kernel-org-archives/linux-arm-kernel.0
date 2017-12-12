From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Dec 2017 19:05:54 -0200
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171212195435.GF10595@n2100.armlinux.org.uk>
References: <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
 <20171212193638.GH7829@linux.vnet.ibm.com>
 <CAOMZO5Brd7pZtF5e8RLu63MpUo1Sc01vWC1WeccEMTkGBL0Rqw@mail.gmail.com>
 <20171212195435.GF10595@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5CD4koxwFONd1R7wU+Nx_+QC9KBUP+mSs7vqk_9buO=8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Dec 12, 2017 at 5:54 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Which is exactly what I would expect with imx6.  Just because it
> works for imx6 does not mean it works for everyone.

Sure, I trust your judgement.

You asked me to test with CONFIG_BL_SWITCHER=y and that's what I did
and reported back.
