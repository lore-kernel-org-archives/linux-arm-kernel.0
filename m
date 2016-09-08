From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 8 Sep 2016 12:54:15 +0200
Subject: [PATCH] KVM: ARM: cleanup kvm_timer_hyp_init
In-Reply-To: <1473331560-3103-1-git-send-email-pbonzini@redhat.com>
References: <1473331560-3103-1-git-send-email-pbonzini@redhat.com>
Message-ID: <20160908105415.GY23592@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 12:45:59PM +0200, Paolo Bonzini wrote:
> Remove two unnecessary labels now that kvm_timer_hyp_init is not
> creating its own workqueue anymore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied.

-Christoffer
