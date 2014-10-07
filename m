From: geoff@infradead.org (Geoff Levand)
Date: Tue, 07 Oct 2014 11:28:59 -0700
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20141007152219.GB27216@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com> <1412370971.32313.30.camel@smoke>
 <20141007152219.GB27216@leverpostej>
Message-ID: <1412706539.32313.89.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2014-10-07 at 16:22 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> > > Does this patch series work with kexec on UEFI machines?
> > 
> > I have not done much more than some simple re-boot tests using the
> > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> > but yes, it should work.
> 
> Where you booting the kernel as an UEFI application, or were you using the
> Linux loader? The latter arguably isn't a UEFI boot because the kernel doesn't
> know of or have access to UEFI (and arguably said laoder shouldn't even be
> there).

I used the Linux loader. 

> I've just had a go on Juno, but I wasn't able to get the tool to work.

No, I wouldn't think it would.  Proper UEFI re-boot is
still todo.

-Geoff
