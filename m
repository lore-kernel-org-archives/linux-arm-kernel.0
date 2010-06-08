From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 14:12:47 +0800
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <201006071712.20888.marek.vasut@gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<201006071712.20888.marek.vasut@gmail.com>
Message-ID: <AANLkTilJoleT450L4-H8ZEeuXKzSmYBVDI9h81KCXZZk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> what about the PXA based devices, where RAM begins at 0x80000000 ?
>

I hope at this stage, it's a 1:1 direct mapping from the original zreladdr-y
variables to CONFIG_ZRELADDR.

But yeah, we can make that change some time later based on this.
