From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 18 May 2016 12:46:38 +0200
Subject: [Xen-devel] [GIT PULL] EFI ARM Xen support
In-Reply-To: <alpine.DEB.2.10.1605171153070.2494@sstabellini-ThinkPad-X260>
References: <20160514190410.GA2283@codeblueprint.co.uk>
 <alpine.DEB.2.10.1605171109170.2494@sstabellini-ThinkPad-X260>
 <573AF50E.9090206@citrix.com>
 <alpine.DEB.2.10.1605171153070.2494@sstabellini-ThinkPad-X260>
Message-ID: <20160518104638.GA19191@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Tue, 17 May 2016, David Vrabel wrote:
> > On 17/05/16 11:12, Stefano Stabellini wrote:
> > > On Sat, 14 May 2016, Matt Fleming wrote:
> > >> Folks,
> > >>
> > >> Please pull the following branch which contains support for Xen on ARM
> > >> EFI platforms.
> > >>
> > >> This merge includes a merge of Stefano's xen/linux-next branch to pull
> > >> in the prerequisites required for Shannon's commit:
> > >>
> > >>   11ee5491e5ff ("Xen: EFI: Parse DT parameters for Xen specific UEFI")
> > >>
> > >> as it needs both the latest changes in the EFI 'next' branch (now
> > >> tip/efi/core) and xen/linux-next.
> > >>
> > >> I have intentionally not included the individual patches as I would
> > >> normally do in a pull request, so that commit history created by my
> > >> merging of Stefano's branch is preserved, and so that there's no way
> > >> to accidentally apply the patches individually.
> > >>
> > >> The following changes since commit 6c5450ef66816216e574885cf8d3ddb31ef77428:
> > >>
> > >>   efivarfs: Make efivarfs_file_ioctl() static (2016-05-07 07:06:13 +0200)
> > >>
> > >> are available in the git repository at:
> > >>
> > >>   git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git efi/arm-xen
> > >>
> > >> for you to fetch changes up to 11ee5491e5ff519e0d3a7018eb21351cb6955a98:
> > >>
> > >>   Xen: EFI: Parse DT parameters for Xen specific UEFI (2016-05-14 19:31:01 +0100)
> > > 
> > > Is this arrangement working for everybody, in particular the tip
> > > maintainers?
> > 
> > Yes.
> 
> I meant the x86 tip maintainers (Thomas, Peter and Ingo).

I have no particular objections, since this seems to be Xen-next merged to the EFI 
tree that is already upstream, plus this single commit on top of t:

  11ee5491e5ff Xen: EFI: Parse DT parameters for Xen specific UEFI

Which, if Matt is fine with it, you could send to Linus too as part of this 
cycle's Xen pull request.

Thanks,

	Ingo
