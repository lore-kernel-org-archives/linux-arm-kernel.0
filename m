From: peda@axentia.se (Peter Rosin)
Date: Wed, 31 May 2017 08:34:00 +0200
Subject: [PATCH 00/58] ARM: at91: rework Atmel TCB drivers
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <da7069d4-e5b3-f10f-0816-ff973195aff6@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-30 23:50, Alexandre Belloni wrote:
> Hi,
> 
> This series reworks the Atmel Timer counter Block drivers. Those blocks
> each have 3 counters with 2 channels each and can be used for
> multiple functions:
>  - timers
>  - PWMs
>  - Quadrature decoders
>  - Stepper motor counters

I'd like to test this, but I have a hard time doing that since all I got
was this cover letter and a single DT-only patch.

I understand that you were reluctant to spam too many people with
dozens of patches, but perhaps the series can be fetched from
somewhere?

Cheers,
peda
