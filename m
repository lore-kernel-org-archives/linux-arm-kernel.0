From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 7 Oct 2014 09:40:06 -0400
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <1412370971.32313.30.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
Message-ID: <20141007134006.GC27464@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
> Hi,
> 
> On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > > Hi All,
> > > 
> > > This series adds the core support for kexec re-boots on arm64.  I have tested
> > > with the ARM VE fast model using various kernel config options for both the
> > > first and second stage kernels.
> > 
> > Does this patch series work with kexec on UEFI machines?
> 
> I have not done much more than some simple re-boot tests using the
> base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> but yes, it should work.

[CC Dave Young ]

I have not looked at the user space patches but are you preparing efi
setup data and passing all the runtime map information to second kernel.

I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
well.

Thanks
Vivek
