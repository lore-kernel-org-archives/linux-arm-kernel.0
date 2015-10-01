From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 1 Oct 2015 17:21:02 +0100
Subject: [PATCH] arm64: Fix THP protection change logic
In-Reply-To: <CAFpQJXVssNN46+fQmqYiiA0hQ0uCMtVHFQKPUeK39dmM1Pxcvw@mail.gmail.com>
References: <1443701167-10816-1-git-send-email-steve.capper@linaro.org>
 <20151001140755.GF6963@e104818-lin.cambridge.arm.com>
 <CAFpQJXVssNN46+fQmqYiiA0hQ0uCMtVHFQKPUeK39dmM1Pxcvw@mail.gmail.com>
Message-ID: <CAPvkgC0oEcfb5pnR_hZDXJc0VxA6edgrCheB5BfYHueuYWtOAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2015 at 17:09, Ganapatrao Kulkarni <gpkulkarni@gmail.com> wrote:
> Thanks Steve.
> this patch fixes the issue i was facing when running applications
> (which forms thp) with auto numa enabled.
>
> Tested-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>

Brilliant, thank you Ganapat.

Catalin, thanks for the review, would you like me to resend with these
two tags added, or are you happy to apply them before merging?

Cheers,
--
Steve
