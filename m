From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 21 Aug 2018 13:06:35 +0200
Subject: [PATCH] KVM: Documentation: rename the capability of
 KVM_CAP_ARM_SET_SERROR_ESR
In-Reply-To: <20180820142925.zw2vgplbutfcvvos@kamzik.brq.redhat.com>
References: <1534801165-41525-1-git-send-email-gengdongjiu@huawei.com>
 <20180820142925.zw2vgplbutfcvvos@kamzik.brq.redhat.com>
Message-ID: <a1d72e58-ce94-e681-bebc-125ea84045d1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/2018 16:29, Andrew Jones wrote:
>> In the documentation description, this capability's name is
>> KVM_CAP_ARM_SET_SERROR_ESR, but in the header file this
>> capability's name is KVM_CAP_ARM_INJECT_SERROR_ESR, so change
>> the documentation description to make it same.
>> 
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Reported-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Queued, thanks.

Paolo
