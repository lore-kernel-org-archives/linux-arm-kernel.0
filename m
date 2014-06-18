From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 18 Jun 2014 11:56:38 -0700
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <20140618164927.GA9612@leverpostej>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke>
 <20140618164927.GA9612@leverpostej>
Message-ID: <CAGa+x85uCquTbimbpAbS5_72RPTWrX-pNp15R63iNat=v4Atjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 9:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:

> What kind of tools do you envision which would need to know the
> endianness of the kernel but would be looking at the Image rather than
> the vmlinux?

Automated boot infrastructure which has access to the [zu]Image but
not the vmlinux and wants to know which endian rootfs to pass to the
kernel.

Kevin
