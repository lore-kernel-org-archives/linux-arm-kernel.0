From: shmulik.ladkani@gmail.com (Shmulik Ladkani)
Date: Sun, 17 Mar 2013 21:58:05 +0200
Subject: [PATCH 1/4] mtd: merge mtdchar module with mtdcore
In-Reply-To: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
References: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
Message-ID: <20130317215805.3246b0b5.shmulik.ladkani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Mar 2013 13:27:40 +0200 Artem Bityutskiy <dedekind1@gmail.com> wrote:
> Indeed, mtdchar is a module that allows user-space making use of MTD devices
> via /dev/mtd* character devices. If users do not enable it, they simply cannot
> use MTD devices at all. The cannot read or write the flash contents. Is it a

s/ The cannot/ They cannot/

What about the defconfig files?

Thanks,
Shmulik
