From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 3 Feb 2016 15:23:52 -0500 (EST)
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <CAKv+Gu_MyPvDnnQ0hScqW6XR77h0MD6LxEb_q2Z-mS0AQw3djA@mail.gmail.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
 <HKXPR06MB05656F902E0E1FBBDBD713DC8AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu8ZTHAqviveLMizRKPfeXwb6kcXi4cVQNYVYuPcVMgMeQ@mail.gmail.com>
 <20160203200107.GD10826@n2100.arm.linux.org.uk>
 <CAKv+Gu_MyPvDnnQ0hScqW6XR77h0MD6LxEb_q2Z-mS0AQw3djA@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1602031522090.17825@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Feb 2016, Ard Biesheuvel wrote:

> On 3 February 2016 at 21:01, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Feb 03, 2016 at 02:41:29PM +0100, Ard Biesheuvel wrote:
> >> > bf353edc T __stubs_start
> >>
> >> This is a global symbol
> >>
> >> > bf353edc T _etext
> >> > bf353ee0 t __stubs_start
> >>
> >> This is a local symbol
> >
> > Stop this madness.  This gets you an immediate NAK on the patch set.
> >
> 
> What madness? This does not change at all with my patches, these
> duplicates already exist in the current code.

That doesn't make it any better, and was cause for issue as Chris 
demonstrated.  Can we get rid of that duplication please?


Nicolas
