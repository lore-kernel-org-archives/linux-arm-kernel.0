From: jsarha@ti.com (Jyri Sarha)
Date: Tue, 28 Jan 2014 09:47:13 +0200
Subject: [PATCH RFC v3 4/8] ASoC: davinci-evm: HDMI audio support for
 TDA998x trough McASP I2S bus
In-Reply-To: <20140127204910.GB11841@sirena.org.uk>
References: <cover.1390836773.git.jsarha@ti.com>
 <86fcca2ecf302a695e7fd8199a1d635a67bbfcc8.1390836773.git.jsarha@ti.com>
 <20140127204910.GB11841@sirena.org.uk>
Message-ID: <52E76081.3030905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 10:49 PM, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 05:37:53PM +0200, Jyri Sarha wrote:
>> Add machine driver support for BeagleBone-Black and other boards with
>> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
>> port in I2S mode. McASP produces the bit clock for the i2s bus from
>> the masted clock by a simple divider and the available sample rates
>
> I have to say I agree with Lars' comments about where the code to set
> the constraints is here - I don't doubt that these limitations are valid
> but it would be better to factor them into the relevant chip drivers so
> that other systems with similar limitations can be handled correctly
> too.
>

Ok, I'll push them into mcasp driver then.

Thanks,
Jyri
