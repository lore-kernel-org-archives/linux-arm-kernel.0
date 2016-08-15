From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 15 Aug 2016 08:25:40 -0600
Subject: [PATCH] Documentation: kprobes: Document jprobes stack copying
 limitations
In-Reply-To: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
References: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
Message-ID: <20160815082540.2b7a889b@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Aug 2016 16:24:44 -0400
David Long <dave.long@linaro.org> wrote:

> Some architectures (i.e.: sparc64 and arm64) make reasonable partial stack
> duplication for jprobes problematic. Document this.

Applied to the docs tree, thanks.

jon
