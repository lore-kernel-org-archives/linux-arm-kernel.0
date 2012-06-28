From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jun 2012 12:03:44 +0100
Subject: [PATCH 1/1] ARM: only call smp_send_stop() on SMP
In-Reply-To: <7C9043C3-3C05-4455-9CCF-A08617CA9D77@gmail.com>
References: <1340511667-4976-1-git-send-email-javier@dowhile0.org>
 <20120624085943.GC19226@n2100.arm.linux.org.uk>
 <7C9043C3-3C05-4455-9CCF-A08617CA9D77@gmail.com>
Message-ID: <20120628110344.GG19226@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 10:06:23AM +0300, Pantelis Antoniou wrote:
> Err,
> 
> There was a patch been sent in response that did exactly as you asked.
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/1205.3/00433.html
> 
> Regards

Obviously it was missed, and no one bothered to re-send it.  Yes, it looks
fine.
