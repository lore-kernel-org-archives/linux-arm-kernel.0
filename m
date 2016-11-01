From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2016 09:36:28 +0000
Subject: [PATCH V4 10/10] arm64: KVM: add guest SEA support
In-Reply-To: <85443ee1-9981-c7e8-fe88-a3aac48c3e80@codeaurora.org>
References: <1477071013-29563-1-git-send-email-tbaicar@codeaurora.org>
 <1477071013-29563-11-git-send-email-tbaicar@codeaurora.org>
 <20161031100206.GX1041@n2100.armlinux.org.uk>
 <85443ee1-9981-c7e8-fe88-a3aac48c3e80@codeaurora.org>
Message-ID: <20161101093628.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 04:36:33PM -0600, Baicar, Tyler wrote:
> Hello Russell,
> 
> On 10/31/2016 4:02 AM, Russell King - ARM Linux wrote:
> >The subject line on this patch is misleading - it's not only ARM64
> >specific...
> Thank you for the feedback!
> 
> I only put ARM64 in the subject line because this patch only really adds
> guest SEA support for the ARM64 KVM code. The ARM code had to be edited
> since both the ARM and ARM64 KVM code use arch/arm/kvm/mmu.c. I can change
> the subject line to "arm/arm64: KVM: add guest SEA support" if you think
> that is better.

Yes please, I almost skipped over it while catching up because it didn't
say "arm", it was only that I'd happened to read the cover message that
I'd spotted arch/arm in the diffstat, and then had to go digging for the
changes to review.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
