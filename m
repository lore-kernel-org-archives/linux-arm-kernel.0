From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 19 Dec 2017 21:56:25 +0300
Subject: [PATCH 4/9] ARM: trusted_foundations: enable L2x0 cache via
 firmware_ops
In-Reply-To: <1d12ea86cca40749731a594afc165830c0b2463d.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <1d12ea86cca40749731a594afc165830c0b2463d.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <31c34cba-f626-5c27-430e-de5edebad843@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.07.2017 03:29, Micha? Miros?aw wrote:
> Use firmware_ops to provide hook for cache initialization through
> Trusted Foundations firmware, as some writes need Secure mode.
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---

I've tested this patch on my T30, which I ported to current linux-next, and it
works excellent. Micha?, are you going to re-spin this patch?
