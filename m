From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 20 Jul 2012 12:56:41 +0530
Subject: [RFC 3/4] ARM: OMAP: powerdomain: Add .power_on/.power_down hooks
 for powerdomains
In-Reply-To: <1342764284-8143-4-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
 <1342764284-8143-4-git-send-email-rnayak@ti.com>
Message-ID: <CAMQu2gw8NviFfB6gVd=jOB5WttzzArCx2TuH_+8MbFf0SVz3rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> With usecounting added to Powerdomains, its now possible to track Powerdomain
> transitions, including when a Powerdomain is turned on and turned down.
> Add support for hooking up callbacks for such events, which can be used to
> do things like context save/restore etc. which today is mostly stuffed within
> CPUidle and Suspend code.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Agree.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
