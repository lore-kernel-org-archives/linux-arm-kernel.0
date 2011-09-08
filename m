From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Sep 2011 11:11:35 +0300
Subject: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <4E6877A9.3090104@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-7-git-send-email-b-cousson@ti.com>
	<CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
	<4E686B71.2060107@ti.com>
	<CAK=WgbYgatyLWqmrZnUfSGxCkZsRiJ3sbQwmenxyiJ6JBw5vJA@mail.gmail.com>
	<4E6877A9.3090104@ti.com>
Message-ID: <CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 11:07 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> The (small) issue for my point of view is that the #hwspinlock is already
> encoded in the IP itself. So adding a baseid directly in DT will look like
> duplicating indirectly something that is already there in the HW.
> That being said, since we cannot rely on the order, we will not be able to
> get the proper baseid until the driver probe every hwspinlock devices :-(
> So baseid might be a easier choice.

Sounds good. Thanks a lot !
