From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 16:00:24 +0100
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <20120823145904.GC1047@gmail.com>
References: <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
 <20120823125903.GA7995@opensource.wolfsonmicro.com>
 <20120823132618.GB1047@gmail.com>
 <20120823143757.GB7995@opensource.wolfsonmicro.com>
 <20120823145904.GC1047@gmail.com>
Message-ID: <20120823150024.GF7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 03:59:06PM +0100, Lee Jones wrote:

> I'll attempt to re-jig the patch-set, as this is a blocker atm.

OK, if we could get at least the DAI driver and arch/arm changes in
that'd at least make the series smaller.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/2f0dd929/attachment.sig>
