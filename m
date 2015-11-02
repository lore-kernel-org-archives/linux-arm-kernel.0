From: cl@linux.com (Christoph Lameter)
Date: Mon, 2 Nov 2015 10:08:46 -0600 (CST)
Subject: [PATCH v6 1/3] percpu: remove PERCPU_ENOUGH_ROOM which is stale
 definition
In-Reply-To: <1446363977-23656-2-git-send-email-jungseoklee85@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-2-git-send-email-jungseoklee85@gmail.com>
Message-ID: <alpine.DEB.2.20.1511021007400.27740@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 1 Nov 2015, Jungseok Lee wrote:

> As pure cleanup, this patch removes PERCPU_ENOUGH_ROOM which is not
> used any more. That is, no code refers to the definition.

Acked-by: Christoph Lameter <cl@linux.com>
