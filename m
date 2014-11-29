From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 29 Nov 2014 12:29:33 +0100
Subject: [RFC PATCH 4/5] ARM: enable linking against eventfd and irqchip
In-Reply-To: <20141124212706.10605.50148.stgit@i3820>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212706.10605.50148.stgit@i3820>
Message-ID: <20141129112933.GF13623@macair>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inidicate KVM in the subject please.

On Mon, Nov 24, 2014 at 11:27:06PM +0200, Nikolay Nikolaev wrote:
> This enables compilation of the eventfd feature on ARM.

does this enable anything else than the ioeventfd stuff so that
everything is in place to do this safely now?

-Christoffer
