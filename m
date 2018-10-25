From: k.marinushkin@gmail.com (Kirill Marinushkin)
Date: Thu, 25 Oct 2018 19:20:40 +0200
Subject: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
In-Reply-To: <s5hftwuo4t0.wl-tiwai@suse.de>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
Message-ID: <5bc8295a-1e38-99b5-d54c-72e920600f83@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Takashi, Mike,

@Takashi

On 10/25/18 09:37, Takashi Iwai wrote:
> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
> updating only delay value.  It implies that the hardware chip doesn't
> provide the hwptr update.

Thank you for the clarification. Modifying `runtime->delay` from the `pointer`
function looked wrong for me. Now I understand the motivation and the use-case.
I will be more careful when analyzing the code which doesn't fit my expectations.

@Mike

I was wrong. You can ignore my comments. Please don't take them personal: it's
all about having high-quality code in kernel.

Best Regards,
Kirill
