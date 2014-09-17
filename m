From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Sep 2014 11:36:00 -0700
Subject: [PATCH v6 1/3] mfd: devicetree: bindings: Add Qualcomm RPM DT
 binding
In-Reply-To: <20140917181939.GG10179@sonymobile.com>
References: <1409029109-28769-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1409029109-28769-2-git-send-email-bjorn.andersson@sonymobile.com>
 <20140826072727.GB9574@lee--X1> <20140917161554.GJ30918@lee--X1>
 <20140917181939.GG10179@sonymobile.com>
Message-ID: <20140917183600.GT7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 11:19:40AM -0700, Bjorn Andersson wrote:

> The regulator driver have a strong dependency on the mfd driver, but Kconfig
> will make sure it's not selectable until the two parts merges again, so it
> should be fine. But I guess it's up to Mark?

Yes, that's the normal approach.  I'd have applied it but a lot of the
early discussion seemed to be about the register I/O interface.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/05508a4a/attachment.sig>
