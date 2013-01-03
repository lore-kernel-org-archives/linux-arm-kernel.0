From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 3 Jan 2013 23:26:16 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP4: clock data: ABE DPLL need to be locked
 on all revisions
In-Reply-To: <50E5D4EA.5030001@ti.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
 <1357220811-29904-2-git-send-email-peter.ujfalusi@ti.com>
 <50E5D4EA.5030001@ti.com>
Message-ID: <alpine.DEB.2.00.1301032325530.24404@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jan 2013, Jon Hunter wrote:

> I am not sure that this change to the comment is completely accurate. On
> OMAP4430 I did not see any issues with the DPLL failing to turn on if
> the DPLL was not locked. I only saw this particular problem on the 4460.
> Therefore, it may be better to leave the comment as-is and add an
> additional sentence to state that the DPLL should be locked for all
> OMAP4 devices for audio to work correctly.

Makes sense to me; what do you think, P?ter?

- Paul
