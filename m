From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2011 11:40:04 +0200
Subject: Enabling runtime P2V by default (Re: [PATCH 3/5] mach-u300: patch
	physoffset by default)
In-Reply-To: <20110810091635.GF1831@n2100.arm.linux.org.uk>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
	<20110810091635.GF1831@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZC=Ny78SuOMVNPedMLERVAFOJTPB79avQ6zyiy-7Kbkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 11:16 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 09, 2011 at 09:41:38PM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This works like a charm so I'll just default-select it.
>
> Well, we can remove the EXPERIMENTAL status of this option now. ?This
> raises the question is whether we should now default it to 'y' - I
> think we should. ?Anyone have any objections?

I agree, no objections. Works flawlessly on all my systems.

Thanks,
Linus Walleij
