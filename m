From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 12 Jan 2015 11:15:00 +0100
Subject: [GIT PULL 0/2] KVM/ARM Fixes for 3.19
In-Reply-To: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
References: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <54B39EA4.50808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/01/2015 14:10, Christoffer Dall wrote:
> Hi Paolo,
> 
> The following changes since commit b1940cd21c0f4abdce101253e860feff547291b0:
> 
>   Linux 3.19-rc3 (2015-01-05 17:05:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-3.19
> 
> for you to fetch changes up to b5b8ddba844c6b6c5b96c27b284d9ed05a16fa13:
> 
>   arm64: KVM: Fix HCR setting for 32bit guests (2015-01-11 13:54:51 +0100)
> 
> (Note that I got an extra merge commit when merging kvm/master into
> kvmarm/master, which I think is because Linus applied the set of fixes
> from kvmarm/master directly from Marc's patches. Let me know if you need
> me to mangle this differently somehow.)

Hmm, that's a bit ugly.  I'll apply the patches directly too, please do
a "git reset --hard kvm/master" before applying more stuff.

Paolo
