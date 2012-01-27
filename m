From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 27 Jan 2012 22:06:40 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120127121311.GB2347@mudshark.cambridge.arm.com>
References: <CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
 <CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
 <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
 <CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
 <CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
 <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVORuy8Mh413op_1vMuFbthp8y+SBM0f78KV2X-jcbv2TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2012 at 8:13 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> There must be something I am missing here.
>
> Did this lead anywhere in the end? It seems as though Ming Lei has a working
> setup but Stephane is unable to replicate it, despite applying the necessary
> patches and trying an updated bootloader.

In fact, I don't think stephane has tried the patch in the link[1] and
reported the
test result, even though I have asked him to do it for several times.

> Drastic suggestion: Stephane, could you try a kernel *binary* from Ming Lei?
> If that works then you're probably just missing a patch. If it doesn't, then
> there must be something different between your boards.

[1], http://marc.info/?l=linux-arm-kernel&m=132697975416659&w=2

thanks,
--
Ming Lei
