From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 11 Sep 2012 17:08:42 +0800
Subject: [PATCH 06/17] Documentation: Define the MOP500 Audio Machine
 Driver Device Tree bindings
In-Reply-To: <504EFEF8.6020707@stericsson.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-7-git-send-email-lee.jones@linaro.org>
 <20120910164413.GC24506@gmail.com>
 <504EFEF8.6020707@stericsson.com>
Message-ID: <20120911090840.GA9381@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 11:06:00AM +0200, Ola Lilja wrote:
> On 09/10/2012 06:44 PM, Lee Jones wrote:

> >> +	msp1: msp at 80124000 {
> >> +		compatible = "stericsson,ux500-msp-i2s";
> >> +		reg = <0x80124000 0x1000>;
> >> +		interrupts = <0 62 0x4>;
> >> +		v-ape-supply = <&db8500_vape_reg>;

> I'm no DT-expert, but why are you adding MSP-stuff in the machine-driver? They
> are also added in the next patch.

This is context for the example - the example is just informative and
tends to include other things so they can be referenced by the main bit
of the example, it's the documentation at the top that's the bindings
themselves.
