From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 22 Feb 2018 16:58:53 +0100
Subject: [PATCH v4 24/40] KVM: arm64: Rewrite system register accessors
 to read/write functions
In-Reply-To: <20180222151138.6753vrly7aldosmm@kamzik.brq.redhat.com>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-25-christoffer.dall@linaro.org>
 <20180222151138.6753vrly7aldosmm@kamzik.brq.redhat.com>
Message-ID: <20180222155853.GS29376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 04:11:38PM +0100, Andrew Jones wrote:
> 
> Hi Christoffer,
> 
> I'm just pointing out some broken lines that we could maybe cheat the
> 80-char limit on. Naturally feel free to ignore.

Thanks.  I'll go over them as I respin.

-Christoffer
