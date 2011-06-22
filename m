From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 22 Jun 2011 13:50:28 +0300
Subject: [RFC 2/8] remoteproc: add omap implementation
In-Reply-To: <BANLkTimAf9EqSX-yHh_0RPaeewndOyNUYA@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-3-git-send-email-ohad@wizery.com>
	<BANLkTimAf9EqSX-yHh_0RPaeewndOyNUYA@mail.gmail.com>
Message-ID: <BANLkTin6eFqQLb-Wkq=Q7rbm7GCjKtz8zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 1:05 PM, Will Newton <will.newton@gmail.com> wrote:
> On Tue, Jun 21, 2011 at 8:18 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>
>> +/* bootaddr isn't needed for the dual M3's */
>> +static inline int omap_rproc_start(struct rproc *rproc, u64 bootaddr)
>
>> +static inline int omap_rproc_stop(struct rproc *rproc)
>
> These two functions don't need to be inline as far as I can see.

They definitely don't need to. Thanks !
