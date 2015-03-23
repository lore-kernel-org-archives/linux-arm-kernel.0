From: geoff@infradead.org (Geoff Levand)
Date: Mon, 23 Mar 2015 08:56:53 -0700
Subject: [RFC 2/4] arm64: kexec: fix kvm issue
In-Reply-To: <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
 <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427126213.27739.3.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-23 at 20:53 +0900, AKASHI Takahiro wrote:
> The current kvm implementation keeps EL2 vector table installed even
> when the system is shut down. This prevents kexec from putting the system
> with kvm back into EL2 when starting a new kernel.

This is a kvm bug fix, so I think the subject should
be something like 'arm64/kvm: Fix shutdown issue'.

-Geoff
