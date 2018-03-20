From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 20 Mar 2018 03:23:04 -0700
Subject: [PATCH v4 3/7] scsi: dpt_i2o: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521514207-10695-4-git-send-email-okaya@codeaurora.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
 <1521514207-10695-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20180320102304.GA21265@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a basically unmaintained driver for historic hardware, and not the
right place for micro-optimizations.
