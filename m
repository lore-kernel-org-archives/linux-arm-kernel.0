From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 26 Oct 2012 16:42:24 -0500
Subject: [PATCH v5] gpio/omap: fix off-mode bug: clear debounce settings
 on free/reset
In-Reply-To: <874nlhhqxt.fsf@deeprootsystems.com>
References: <1351279564-4591-1-git-send-email-jon-hunter@ti.com>
 <874nlhhqxt.fsf@deeprootsystems.com>
Message-ID: <508B03C0.3080404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/26/2012 04:19 PM, Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
>> This change was originally titled "gpio/omap: fix off-mode bug: clear debounce
>> clock enable mask on free/reset". The title has been updated slightly to
>> reflect (what should be) the final fix.
> 
> nit: this kind of thing should typically go after the '---' since it's
> useful reviewers/maintainers but not necessarily in the permanant git
> history.

Thanks for the tip.

Linus, let me know if I should resend.

Cheers
Jon
