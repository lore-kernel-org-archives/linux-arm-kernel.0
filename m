From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 16:53:38 +0100
Subject: [PATCH] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <53DA660D.3070504@linaro.org>
References: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9hwupNAxuOTNnsY8Spxkh3J6DwYF7Ym493PuZ-6phzXA@mail.gmail.com>
 <53DA509A.8070304@linaro.org>
 <CAKv+Gu8Nq7-mhFPRqRw6sxDxZAz5kyLvDBwC_0E3qZp9ZpxPig@mail.gmail.com>
 <53DA660D.3070504@linaro.org>
Message-ID: <20140731155338.GC26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 04:51:41PM +0100, Yi Li wrote:
> On Thursday, July 31, 2014 10:26 PM, Ard Biesheuvel wrote:
> > On 31 July 2014 16:20, Yi Li <yi.li@linaro.org> wrote:
> >> Hi Ard,
> >>
> >>      The patch works well on FVP model, and here are the boot log and
> >> dmidecode+lshw result:
> >>
> > Thanks Yi!
> >
> > Can we help Will out if he wants to test this himself?
>      @Will: which platform do you have on hand?  I am using FVP model 
> for testing.
>      First, you need to merge SMBIOS support into UEFI.
>      Then, compile and install the dmidecode(open source) on the linux 
> ,and run it.

I've got some stuff from Leif for testing this, but what I'm really after is
something that would have spotted this problem. Are there any compliance
tests, for example?

Will
