From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 29 Apr 2013 12:40:23 +0930
Subject: [PATCH 1/2] virtio: console: Add early writeonly register to
 config space
In-Reply-To: <1366974299-17877-2-git-send-email-pranavkumar@linaro.org>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <1366974299-17877-2-git-send-email-pranavkumar@linaro.org>
Message-ID: <87mwsic9r4.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
> This patch adds a early_wr register (writeonly) in config space of virtio console device which can be used for debugging.
>
> The patch also updates virtio-spec in Documentation to reflect this feature addition in virtio console.

Perhaps change the name to VIRTIO_CONSOLE_F_EMERGENCY_WRITE.  But let's
resolve the qemu discussion first...

Cheers,
Rusty.
