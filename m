From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 15:59:29 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable CONFIG_FHANDLE
In-Reply-To: <7h37qvn4v5.fsf@baylibre.com>
References: <1460023562-7907-1-git-send-email-nsekhar@ti.com>
 <7h37qvn4v5.fsf@baylibre.com>
Message-ID: <570B7C89.9030200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 April 2016 03:24 AM, Kevin Hilman wrote:
> Sekhar Nori <nsekhar@ti.com> writes:
> 
>> CONFIG_FHANDLE is required by systemd, which is the
>> default init system in more and more distributions.
> 
> There's a bunch more options required for basic systemd support also[1],
> so those should probably be added with the changelog referencing the
> source[1]

Good point. Will send a v2.

Regards,
Sekhar
