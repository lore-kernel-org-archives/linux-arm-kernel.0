From: ken.xue@amd.com (Ken Xue)
Date: Thu, 10 Dec 2015 15:19:10 +0800
Subject: [PATCH 1/2] acpi:apd: Add APM X-Gene ACPI I2C device support
In-Reply-To: <CAPw-ZTnReGBAJWyj13=bov=A7WX5oZnrW8MDzUUVTjHkd3xkKg@mail.gmail.com>
References: <1449533774-22672-1-git-send-email-lho@apm.com>
 <1449533774-22672-2-git-send-email-lho@apm.com>
 <1449542948.2175.41.camel@kxue-X58A-UD3R>
 <CAPw-ZTkxhdEmOP_DN=Cv1MmPw5UsZHcd-kLVbqYFJU8-6=sc+A@mail.gmail.com>
 <1449728072.4557.22.camel@kxue-X58A-UD3R>
 <CAPw-ZTnReGBAJWyj13=bov=A7WX5oZnrW8MDzUUVTjHkd3xkKg@mail.gmail.com>
Message-ID: <1449731950.4557.24.camel@kxue-X58A-UD3R>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-09 at 22:57 -0800, Loc Ho wrote:
> >> Sure you want this?
> > Yes. Even though it may look like too much macros for just several
> > devices now. But I think AMD and other ARM socs may also try to leverage
> > APD for more and more ACPI devices.
> > It is a good direction that 1)improve efficiency of matching ACPI
> > handler 2) split devices and potential hook routines into different
> > classes clearly
> >
> > It also will be more convenient to move ARM devices out of APD if there
> > is a new design for ARM ACPI device.
> >
> 
> Okay... I will generate v2 when ready. One more question, does AMD
> ARM64 SoC need it later?
> 

Thanks. I am not sure about driver design for AMD ARM64 SoC.
