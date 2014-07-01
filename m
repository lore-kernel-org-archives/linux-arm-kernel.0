From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 1 Jul 2014 14:48:31 +0100
Subject: [PATCH v2 1/2] efi/x86: move UEFI Runtime Services wrappers to
 generic code
In-Reply-To: <CAKv+Gu_hyXaFEydpRQCB0vP260oJpFftytN_Ex++shMdpFpafg@mail.gmail.com>
References: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>
 <1403777346-28629-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140701133033.GD7539@console-pimps.org>
 <CAKv+Gu_hyXaFEydpRQCB0vP260oJpFftytN_Ex++shMdpFpafg@mail.gmail.com>
Message-ID: <20140701134831.GE7539@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 Jul, at 03:35:09PM, Ard Biesheuvel wrote:
> 
> I agree, but I kind of followed the example of the Kconfig symbols in
> the vicinity.
> So sure, rip it out. Or would you like me to do a v(n+1)?

Thanks. Nah, no need for another version, I'ved fixed this up in 'next',
but please do check the commits to make sure nothing untoward has
occurred.

-- 
Matt Fleming, Intel Open Source Technology Center
