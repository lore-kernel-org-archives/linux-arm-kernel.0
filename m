From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Nov 2014 14:50:55 +0000
Subject: [PATCH 1/4] ASoC: ALC5631: Add device tree binding documentation
In-Reply-To: <E07FA6F208344BC093C8D95F677E8F4A@sisodomain.com>
References: <1415606519-30744-1-git-send-email-krishna.md@samsung.com>
 <1415606519-30744-2-git-send-email-krishna.md@samsung.com>
 <20141110133708.GQ3815@sirena.org.uk>
 <E07FA6F208344BC093C8D95F677E8F4A@sisodomain.com>
Message-ID: <20141110145055.GS3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 07:39:51PM +0530, D Krishna Mohan wrote:
> Hi Mark Brown,

Don't top post.

>     The codec driver is present in mainline as rt5631.c., Its realtek's
> alc5631 so retained that name.
> Similarly machine driver also is named as arndale_rt5631.c but inside that
> driver I have used alc5631 naming as the
> audio daughter card on arndale board mentions alc5631 so I have used this
> convention here so that user should not
> feel the absence of the driver.

> Is that ok or do you want to have one naming all over?

Ugh, OK.  That was hidden at the back end of the series.  Please:

 - Use subject lines matching the style for the subsystem.
 - Support both variants of the device name, not just one.
 - of_match_table() is there to reduce ifdefs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/3ec561eb/attachment-0001.sig>
