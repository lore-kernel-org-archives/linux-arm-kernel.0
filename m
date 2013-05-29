From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 29 May 2013 13:33:54 -0700
Subject: [PATCH v3 0/5] rtc-at91rm9200: add shadow interrupt mask
In-Reply-To: <1369298335-24597-1-git-send-email-jhovold@gmail.com>
References: <1364983415-20298-1-git-send-email-jhovold@gmail.com>
 <1369298335-24597-1-git-send-email-jhovold@gmail.com>
Message-ID: <20130529133354.dd181c845ee4e96527483345@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013 10:38:50 +0200 Johan Hovold <jhovold@gmail.com> wrote:

> This is an update of the shadow-interrupt-mask series against v3.10-rc2.
> 
> I guess we need Atmel to confirm that all sam9x5 SoCs are indeed
> affected. If not, then some probing mechanism as the one Doug suggested
> could be implemented on top of (a subset of) these patches. What do you
> say, Nicolas?
> 
> Note that the first patch (adding a missing OF compile guard) could be
> applied straight away.

At this stage it is unclear to me how to proceed with patches 2-5.
