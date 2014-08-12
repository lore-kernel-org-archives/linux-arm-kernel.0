From: dyoung@redhat.com (Dave Young)
Date: Tue, 12 Aug 2014 15:14:43 +0800
Subject: [PATCH 1/5] efi: move noefi early param code out of x86 arch code
In-Reply-To: <53E9B9B3.1050504@infradead.org>
References: <1407823822-23829-1-git-send-email-dyoung@redhat.com>
 <53E9B9B3.1050504@infradead.org>
Message-ID: <20140812071443.GB14031@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/14 at 11:52pm, Randy Dunlap wrote:
> On 08/11/14 23:10, Dave Young wrote:
> > noefi param can be used for arches other than X86 later, thus move it out of
> > x86 platform code.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/efi.c | 10 +---------
> >  drivers/firmware/efi/efi.c  | 13 +++++++++++++
> >  include/linux/efi.h         |  1 +
> >  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> This line in Documentation/kernel-parameters.txt needs to be updated:
> 
> 	noefi		[X86] Disable EFI runtime services support.

Randy, thanks

Will update the documentation.

Dave
