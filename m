From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 08 Apr 2016 14:54:38 -0700
Subject: [PATCH] ARM: davinci_all_defconfig: enable CONFIG_FHANDLE
In-Reply-To: <1460023562-7907-1-git-send-email-nsekhar@ti.com> (Sekhar Nori's
 message of "Thu, 7 Apr 2016 15:36:02 +0530")
References: <1460023562-7907-1-git-send-email-nsekhar@ti.com>
Message-ID: <7h37qvn4v5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> CONFIG_FHANDLE is required by systemd, which is the
> default init system in more and more distributions.

There's a bunch more options required for basic systemd support also[1],
so those should probably be added with the changelog referencing the
source[1]

Kevin

[1] https://github.com/systemd/systemd/blob/master/README#L37
