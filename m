From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 1 Dec 2011 17:59:54 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <20111201172623.GA7580@debian>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
 <CAH+eYFBM36VqYAqZdiZnMP7AODh_SqYQWuoFDSyS3BDZDvHU5A@mail.gmail.com>
 <20111128174122.GG2465@localhost.localdomain>
 <20111201172623.GA7580@debian>
Message-ID: <20111201175954.GE2026@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 10:56:40PM +0530, Rabin Vincent wrote:
> On Mon, Nov 28, 2011 at 05:41:22PM +0000, Dave Martin wrote:
> > Rabin, did the __opcode_read stuff look useful for ftrace?  My idea
> > was to factor out the logic of how to read/write a whole instruction,
> > but my proposal may be overkill...
> 
> No.  ftrace just uses probe_kernel_read() and always reads a 32-bit
> instruction.

Right -- fair enough.

---Dave
