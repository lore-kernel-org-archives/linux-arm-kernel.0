From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Aug 2016 20:15:09 +0200
Subject: [PATCH] arm64: KVM: Save two instructions in __guest_enter()
In-Reply-To: <daa6aa0c-27d0-25bd-02fd-4e87e9a908fe@codeaurora.org>
References: <1470791736-13949-1-git-send-email-shankerd@codeaurora.org>
 <20160825133122.GA8016@lvm>
 <daa6aa0c-27d0-25bd-02fd-4e87e9a908fe@codeaurora.org>
Message-ID: <20160829181509.GC10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 10:22:06AM -0500, Shanker Donthineni wrote:
> Hi Christoffer,
> 
> This is change may not provide the measurable performance
> improvement, but still we can
> save a few cpu cycles on vCPU context switch and also improves the
> code readability.

I'm not so convinced about saving CPU cycles, but now when I've reviewed
your patch I think it has potential to slightly improve the code.  See
my review of your patch.

-Christoffer
