From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 19 Oct 2016 12:22:43 +0100
Subject: [PATCH 1/2] efi: add support for seeding the RNG from a UEFI
 config table
In-Reply-To: <CAKv+Gu9g1W8EfnJN2Y_Xgo=QKC1gHa95rjO32Dqt4uT+amzhnQ@mail.gmail.com>
References: <1475749646-10844-1-git-send-email-ard.biesheuvel@linaro.org>
 <1475749646-10844-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161019110926.GG9616@leverpostej>
 <CAKv+Gu9g1W8EfnJN2Y_Xgo=QKC1gHa95rjO32Dqt4uT+amzhnQ@mail.gmail.com>
Message-ID: <20161019112243.GD31476@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Oct, at 12:13:55PM, Ard Biesheuvel wrote:
> On 19 October 2016 at 12:09, Mark Rutland <mark.rutland@arm.com> wrote:
>
> > I think to some extent this mush be treated as an ABI, given cases like
> > kexec.
> >
> 
> Perhaps, yes. That would also allow GRUB or other EFI aware
> bootloaders to generate the seed.

If we're going to go down this route, we should try and get the GUID
into the UEFI spec.
