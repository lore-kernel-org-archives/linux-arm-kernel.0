From: dave.long@linaro.org (David Long)
Date: Mon, 15 Aug 2016 10:49:36 -0400
Subject: [PATCH] Documentation: kprobes: Document jprobes stack copying
 limitations
In-Reply-To: <20160815082540.2b7a889b@lwn.net>
References: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
 <20160815082540.2b7a889b@lwn.net>
Message-ID: <57B1D680.9030605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2016 10:25 AM, Jonathan Corbet wrote:
> On Fri, 12 Aug 2016 16:24:44 -0400
> David Long <dave.long@linaro.org> wrote:
>
>> Some architectures (i.e.: sparc64 and arm64) make reasonable partial stack
>> duplication for jprobes problematic. Document this.
>
> Applied to the docs tree, thanks.
>
> jon
>

Was kind of hoping to see an ack (or critique) from a sparc maintainer.

Thanks,
-dl
