From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Jun 2015 12:18:25 +0100
Subject: [PATCH 1/8] of/fdt: split off FDT self reservation from
 memreserve processing
In-Reply-To: <CAKv+Gu9+QZstC2i0Ks32_zb_S9dmj6vyEJOZEWjBvLoNWtOsPA@mail.gmail.com>
References: <1431326520-17331-1-git-send-email-ard.biesheuvel@linaro.org>
 <1431326520-17331-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150522103541.GU29424@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8-av3xTTf=YHAmU2TBuQrBWAS4WBLwK9hfgZbX0YH89A@mail.gmail.com>
 <20150601095655.GB22406@leverpostej>
 <CAKv+Gu-FM-RGiavw6m599uyBBpCCPT1Wn6WNko46wozRONv6vQ@mail.gmail.com>
 <20150601110241.GA7443@leverpostej>
 <CAKv+Gu9+QZstC2i0Ks32_zb_S9dmj6vyEJOZEWjBvLoNWtOsPA@mail.gmail.com>
Message-ID: <20150601111824.GC7443@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Do we have/need acks from Ben or Paul on this reservation patch?
> >
> 
> Considering that this patch is essentially a partial revert of
> d1552ce449eb0 ("of/fdt: move memreserve and dtb memory reservations
> into core") by Rob, who acked this patch and submitted his patch
> without the acks of either Ben or Paul, and the fact that Ben and Paul
> (and Russell) have all been cc'ed at least 3 times on this patch, my
> take would be that it should be fine to go ahead without them. But it
> is ultimately up to Catalin, of course.

That sounds fine to me also, just thought I should check.

Mark.
