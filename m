From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 27 Nov 2017 21:55:58 +0100
Subject: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
In-Reply-To: <20171127195830.GB16941@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
 <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
 <20171127195830.GB16941@cbox>
Message-ID: <ef5e2cad-9db2-b216-85fd-d56aa8f51a53@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2017 20:58, Christoffer Dall wrote:
> Going back and looking, it's nicer to avoid the pid adjustment call, and
> having vcpu_load be void is also convenient, but we're stuck with the
> ifdef.  I guess I lean towards your suggestion as well, given that my
> problem with the ifdef is not a technical one, but an aesthetic one.

Same here, so I think we're in agreement.

Paolo
