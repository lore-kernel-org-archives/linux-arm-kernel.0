From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Sat, 16 Aug 2014 13:45:33 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAJvTdKnTLtozLZnAJcgZODV9-D77u3=hK3d7z-5XCZZTFwhqOg@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAJvTdKnTLtozLZnAJcgZODV9-D77u3=hK3d7z-5XCZZTFwhqOg@mail.gmail.com>
Message-ID: <20140816124532.GA25975@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 06:43:10PM -0400, Len Brown wrote:
> > Additional driver specific
> > +data should be passed in the appropriate _DSM (ACPI Section 9.14.1) method or
> > +_DSD (ACPI Section 6.2.5).
> 
> Re: _DSD
> 
> Yes.
> 
> Re: _DSM
> 
> No, not if it can be handled by _DSD.
> 
> cheers,
> Len Brown, Intel Open Source Technology Center

Thanks good point, Ill update that paragraph to indicate preference on
_DSD.

Graeme
