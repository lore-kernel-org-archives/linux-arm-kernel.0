From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 29 Jun 2011 02:00:31 +0300
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <BANLkTim+CemMz7A3J94e1UywCNd0r1SABQ@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-8-git-send-email-ohad@wizery.com>
	<20110627222121.GD20865@ponder.secretlab.ca>
	<BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com>
	<BANLkTim+CemMz7A3J94e1UywCNd0r1SABQ@mail.gmail.com>
Message-ID: <BANLkTi=16XEpvhWEAoUt_s5F41czeq2DVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 1:51 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> It's not the device_for_each_child() that you're 'putting' back from
> here. ?Its the original kref initialization when the device was
> created.

device_unregister() is already calling put_device(), doesn't that deal
with the original kref init for us ?
