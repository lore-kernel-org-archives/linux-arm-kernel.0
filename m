From: drjones@redhat.com (Andrew Jones)
Date: Fri, 15 Jan 2016 12:16:03 +0100
Subject: [PATCH v9 20/21] KVM: ARM: Introduce per-vcpu kvm device controls
In-Reply-To: <1452839275-19368-21-git-send-email-zhaoshenglong@huawei.com>
References: <1452839275-19368-1-git-send-email-zhaoshenglong@huawei.com>
 <1452839275-19368-21-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160115111603.GF3915@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:27:54PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> In some cases it needs to get/set attributes specific to a vcpu and so
> needs something else than ONE_REG.
> 
> Let's copy the KVM_DEVICE approach, and define the respective ioctls
> for the vcpu file descriptor.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
> CC: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Andrew Jones <drjones@redhat.com>
