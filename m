From: krishna.md@samsung.com (D Krishna Mohan)
Date: Mon, 10 Nov 2014 19:39:51 +0530
Subject: [PATCH 1/4] ASoC: ALC5631: Add device tree binding documentation
In-Reply-To: <20141110133708.GQ3815@sirena.org.uk>
References: <1415606519-30744-1-git-send-email-krishna.md@samsung.com>
 <1415606519-30744-2-git-send-email-krishna.md@samsung.com>
 <20141110133708.GQ3815@sirena.org.uk>
Message-ID: <E07FA6F208344BC093C8D95F677E8F4A@sisodomain.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark Brown,

     The codec driver is present in mainline as rt5631.c., Its realtek's 
alc5631 so retained that name.
Similarly machine driver also is named as arndale_rt5631.c but inside that 
driver I have used alc5631 naming as the
audio daughter card on arndale board mentions alc5631 so I have used this 
convention here so that user should not
feel the absence of the driver.

Is that ok or do you want to have one naming all over?

-Krishna


--------------------------------------------------
From: "Mark Brown" <broonie@kernel.org>
Sent: Monday, November 10, 2014 7:07 PM
To: "Krishna Mohan Dani" <krishna.md@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>; 
<linux-arm-kernel@lists.infradead.org>; <alsa-devel@alsa-project.org>; 
<kgene.kim@samsung.com>
Subject: Re: [PATCH 1/4] ASoC: ALC5631: Add device tree binding 
documentation

On Mon, Nov 10, 2014 at 01:31:56PM +0530, Krishna Mohan Dani wrote:
> Document the device tree binding for the ALC5631 codec and update vendor
> specific prefix for the Realtek.

This driver isn't in mainline, you need to submit the driver. 
