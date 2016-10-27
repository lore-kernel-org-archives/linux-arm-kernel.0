From: eric@anholt.net (Eric Anholt)
Date: Thu, 27 Oct 2016 11:00:27 -0700
Subject: [PATCH 2/2] ARM: dts: bcm283x: fix typo in mailbox address
In-Reply-To: <1477505640-26658-2-git-send-email-stefan.wahren@i2se.com>
References: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
 <1477505640-26658-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <877f8ty8n8.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The address of the mailbox node in the bcm283x.dts has also a typo.
> So fix it accordingly.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 05b682b7a3b2 ("ARM: bcm2835: dt: Add the mailbox to the device tree")

I've marked these to be applied once Rob acks the docs change.
