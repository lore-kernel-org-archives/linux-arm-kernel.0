From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 15 Mar 2013 10:46:13 +0000
Subject: Anyone implement Cortex A9 FIQ
In-Reply-To: <CAHrpEqSQ1n_WUfxoraKZFS2A8NjdP_MCcWmJdCjcon_QwgX4Hw@mail.gmail.com>
References: <CAHrpEqSQ1n_WUfxoraKZFS2A8NjdP_MCcWmJdCjcon_QwgX4Hw@mail.gmail.com>
Message-ID: <5142FBF5.3010307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On 15/03/13 07:38, Frank Li wrote:
> All:
>              Recently, we need real time work run in cortex A9.
>              Did anyone use FIQ on Cortex A9?
>

What are you actually trying to do? There's quite a lot more complexity 
to being able to do real-time work on an A-class processor than just 
using FIQ, and much of that would be platform specific. For example on 
ARMv7A, we generally can't assume that FIQ can be used by the non-secure 
world...


Jonny
