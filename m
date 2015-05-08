From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 May 2015 19:21:07 +0200
Subject: [PATCH v3 11/12] KVM: arm64: enable KVM_CAP_SET_GUEST_DEBUG
In-Reply-To: <1430989647-22501-4-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
 <1430989647-22501-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150508172107.GL24744@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 10:07:14AM +0100, Alex Benn?e wrote:
> Finally advertise the KVM capability for SET_GUEST_DEBUG. Once arm
> support is added this check can be moved to the common
> kvm_vm_ioctl_check_extension() code.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
