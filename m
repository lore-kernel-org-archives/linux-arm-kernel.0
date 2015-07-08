From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 8 Jul 2015 12:03:02 +0200
Subject: [PATCH v8 11/11] KVM: arm64: add trace points for guest_debug
 debug
In-Reply-To: <1436286603-15192-12-git-send-email-alex.bennee@linaro.org>
References: <1436286603-15192-1-git-send-email-alex.bennee@linaro.org>
 <1436286603-15192-12-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150708100302.GE13530@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 05:30:03PM +0100, Alex Benn?e wrote:
> This includes trace points for:
>   kvm_arch_setup_guest_debug
>   kvm_arch_clear_guest_debug
> 
> I've also added some generic register setting trace events and also a
> trace point to dump the array of hardware registers.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Seems like a lot of traces, but I guess that doesn't hurt anything:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
