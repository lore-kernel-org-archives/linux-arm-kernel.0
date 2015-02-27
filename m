From: corbet@lwn.net (Jonathan Corbet)
Date: Fri, 27 Feb 2015 15:08:10 -0700
Subject: [PATCH] genirq: better describe IRQF_NO_SUSPEND semantics
In-Reply-To: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
References: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150227150810.685084df@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Feb 2015 14:53:46 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> This patch updates the documentation regarding IRQF_NO_SUSPEND to make
> this caveat explicit, hopefully making future misuse rarer. Cleanup of
> existing misuse will occur as part of later patch series.

Applied (with Peter's ack) to the docs tree.

Thanks,

jon
