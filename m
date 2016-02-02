From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Feb 2016 18:06:22 +0000
Subject: [RFC PATCH 0/3] arm64 initrd mapping/relocation
In-Reply-To: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160202180622.GP10166@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 06:56:39PM +0100, Ard Biesheuvel wrote:
> After discussing in linux-efi with Mark, and on #armlinux with Will, this is
> a proposal for dealing with initrd memory that is potentially not covered by
> the linear region.
> 
> Note that this will look slightly differently when some of the KASLR work gets
> merged, but this should only affect the way we deal with the initrd if it sits
> outside of the linear region.
> 
> Mostly intended for discussion, not tested at all.

Thanks Ard, this looks like a much better approach to me. Mark -- does
the general idea work for you too?

Will
