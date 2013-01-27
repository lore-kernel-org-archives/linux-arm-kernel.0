From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Sun, 27 Jan 2013 14:55:41 +0100
Subject: [PATCH v3 3/8] input: touchscreen: ti_tsc: remove unwanted fifo
 flush
In-Reply-To: <0110c0cb0cbd3c31dfd3f098f207cd5b765d247e.1358502134.git.rachna@ti.com>
 (Rachna Patil's message of "Fri, 18 Jan 2013 16:18:06 +0530")
References: <cover.1358502134.git.rachna@ti.com>
 <0110c0cb0cbd3c31dfd3f098f207cd5b765d247e.1358502134.git.rachna@ti.com>
Message-ID: <87zjzubuhu.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "P" == Patil, Rachna <rachna@ti.com> writes:

 P> From: "Patil, Rachna" <rachna@ti.com>
 P> When touchscreen and ADC are used together, this
 P> unwanted fifo flush leads to loss of ADC data.

Any special reason why you're wrapping your commit messages after 50
chars, and not the more standard ~70 chars?

It would be good with some more detailed commit text. Is the flush done
somewhere else now? What happens on boards where you don't use the adc
part?

-- 
Bye, Peter Korsgaard
