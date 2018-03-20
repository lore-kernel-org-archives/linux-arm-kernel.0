From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Tue, 20 Mar 2018 08:13:30 -0400
Subject: [PATCH v4 3/7] scsi: dpt_i2o: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <20180320102304.GA21265@infradead.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
 <1521514207-10695-4-git-send-email-okaya@codeaurora.org>
 <20180320102304.GA21265@infradead.org>
Message-ID: <fe8fe164a7b3c4372c3e12d43a6e48c2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-20 06:23, Christoph Hellwig wrote:
> This is a basically unmaintained driver for historic hardware, and not 
> the
> right place for micro-optimizations.

Sure, I can drop this on the next version.
