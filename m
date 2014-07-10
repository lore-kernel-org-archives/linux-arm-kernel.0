From: andi@firstfloor.org (Andi Kleen)
Date: Thu, 10 Jul 2014 02:03:18 +0200
Subject: [RFC/PATCH RESEND -next 00/21] Address sanitizer for kernel
 (kasan) - dynamic memory error detector.
In-Reply-To: <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <53BDB1D6.1090605@intel.com> <8761j6nr53.fsf@tassilo.jf.intel.com>
 <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
Message-ID: <20140710000318.GO18735@two.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> FWIW, I definitely agree with this -- if KASAN can do everything that
> kmemcheck can, it is no doubt the right way forward.

Thanks

BTW I didn't want to sound like I'm against kmemcheck. It is a very
useful tool and was impressive work given the constraints (no help from
the compiler)

-andi
