From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 23 Apr 2012 13:19:29 -0700
Subject: Possible integer overflow in mach-bcmring with FPGA11107
In-Reply-To: <86r4veipp8.fsf@gandalf.zerties.org>
References: <86r4veipp8.fsf@gandalf.zerties.org>
Message-ID: <4F95B951.6020700@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2012 5:43 AM, Christian Dietrich wrote:
>
> This seems totally innocent, but when doing the caluculation for
> rate_hz by hand (or python) the result is slighly bigger than
> 2^32-1. Therfore an integer overflow should occur and the rate_hz rate
> will be far too low. It may be that there is a sanity check in
> hardware, but i don't know the used hardware at all.
>
Hi Christian,

Yes. This is a problem. I will cleanup fpga11107 code including this soon.

Thanks,
JD
