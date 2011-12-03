From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 3 Dec 2011 08:01:09 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <1322867384.11728.20.camel@pasglop>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <1322867384.11728.20.camel@pasglop>
Message-ID: <CAK=WgbYgbShjuFozOQh5Zk+Dh7jymrvtSiVFHzDLB4Nk0zMNaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 3, 2011 at 1:09 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Have you measured the impact of using normal barriers (non-SMP ones)
> like we use on normal HW drivers unconditionally ?
>
> IE. If the difference is small enough I'd say just go for it and avoid
> the bloat.

I agree.

MST wanted to give this a try this week. If all goes well and there's
no unreasonable regression, we'd just switch to mandatory barriers.

Ohad.
