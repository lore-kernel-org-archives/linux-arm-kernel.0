From: penberg@iki.fi (Pekka Enberg)
Date: Sun, 01 Mar 2015 12:21:23 +0200
Subject: stand-alone kvmtool
In-Reply-To: <87mw41aqbc.fsf@linaro.org>
References: <54DDD465.3050300@arm.com> <20150218155042.GF22017@arm.com>
 <54EAFCE9.5030000@arm.com> <87mw41aqbc.fsf@linaro.org>
Message-ID: <54F2E823.6030305@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/26/15 1:02 PM, Alex Benn?e wrote:
> If you can have it all it would be nice to preserve buildability all
> through your history for bisecting (and the moon on a stick please ;-)
>
> Is the dependency on the kernel sources something that has been stable
> over the projects history or something that's been declining/increasing
> over time?

AFAICT, it's been mostly stable after the initial sweep to use 
kernel-provided data structures such as lists and rbtrees.

- Pekka
