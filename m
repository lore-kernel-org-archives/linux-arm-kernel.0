From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Nov 2018 09:36:15 +0100
Subject: [RFC PATCH v3 07/17] clocksource: sun4i: add a compatible for
 suniv
In-Reply-To: <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <20181122083615.2ksgpvmfllbqnfiu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 09:30:40PM +0300, Mesih Kilinc wrote:
> The suniv (new F-series) chip has a timer with less functionality than
> the A10 timer, e.g. it has only 3 channels.
> 
> Add a new compatible for it. As we didn't use the extra channels on A10
> either now, the code needn't to be changed.
> 
> The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.
> 
> Register sun4i_timer as sched_clock on it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181122/5f757349/attachment.sig>
