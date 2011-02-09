From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 9 Feb 2011 21:07:19 +0000
Subject: [PATCH v2] tty: Add msm_smd_tty driver
In-Reply-To: <1297278994-22155-1-git-send-email-nvishwan@codeaurora.org>
References: <1297278994-22155-1-git-send-email-nvishwan@codeaurora.org>
Message-ID: <20110209210719.185834c1@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  9 Feb 2011 11:16:34 -0800
Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:

> msm_smd_tty driver provides tty device interface
> to 'DS' and 'GPSNMEA' streaming SMD ports.
> 
> Cc: Brian Swetland <swetland@google.com>
> Signed-off-by: Niranjana Vishwanathapura <nvishwan@codeaurora.org>

Acked-by: Alan Cox <alan@linux.intel.com>

Thanks for reworking it for the current refcount/port stuff

Alan
