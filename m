From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 15 Dec 2010 06:26:33 -0800
Subject: [PATCH 1/2] msm: gpiomux: Improve gpiomux interface design.
In-Reply-To: <1292259770-22972-1-git-send-email-gbean@codeaurora.org>
References: <1292259770-22972-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1292423193.13887.1.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-12-13 at 09:02 -0800, Gregory Bean wrote:
> Fix the gpiomux interface by:
> - collapsing redundant abstractions into shared common ones
> - disconnecting gpiomux abstractions from particular MSM implementations
> - moving platform-specific details out of the common abstraction
> - moving implementation complexity out of the interface and back into
>   the implementation, where it should have been in the first place
> - allowing for the future extension of the set of power states
> - disambiguating 'settings' and 'configurations'.
> - improving the initialization sequence to provide more flexibility
> - not forcing lines to reset to input mode at power transitions

Your doing too much in too large a patch. Could you break this up into
multiple patches?

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
