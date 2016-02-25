From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Thu, 25 Feb 2016 21:00:45 +0530
Subject: [PATCH v3 2/2] iio: dac: vf610_dac: Add IIO DAC driver for
 Vybrid SoC
In-Reply-To: <56CE18AC.6020603@kernel.org>
References: <cover.1456121233.git.maitysanchayan@gmail.com>
 <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
 <20160223205437.GA27366@rob-hp-laptop>
 <56CE18AC.6020603@kernel.org>
Message-ID: <20160225153045.GA15913@Sanchayan-Arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 16-02-24 20:55:08, Jonathan Cameron wrote:
> On 23/02/16 20:54, Rob Herring wrote:
> > On Mon, Feb 22, 2016 at 11:48:37AM +0530, Sanchayan Maity wrote:
> >> Add driver support for DAC peripheral on Vybrid SoC.
> >>
> >> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
> >>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
> > 
> > For the binding:
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> Applied to the togreg branch of iio.git - initially pushed out as testing
> for the autobuilders to play with it.

Thanks Jonathan.

> 
> Note the dts change probably wants to go via the relevant arch trees.
> I can take it with an appropriate ack if not.

Generally shawn picks up the device tree changes once the driver makes
it to his for-next branch. I will ping shawn to pick this up once the
driver lands in shawn's for-next branch.

Regards,
Sanchayan.
