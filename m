From: ccross@android.com (Colin Cross)
Date: Sun, 1 May 2011 23:59:51 -0700
Subject: [PATCH 1/4] ARM: tegra: irq: convert to gic arch extensions
In-Reply-To: <20110502053735.68CF01537B0@gemini.denx.de>
References: <1304284213-11950-1-git-send-email-ccross@android.com>
	<1304284213-11950-2-git-send-email-ccross@android.com>
	<20110502053735.68CF01537B0@gemini.denx.de>
Message-ID: <BANLkTinDRMFGsgrbXjwXbimu2KtuGxOKgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 1, 2011 at 10:37 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Colin Cross,
>
> In message <1304284213-11950-2-git-send-email-ccross@android.com> you wrote:
>> Replace the ugly hack that inserts legacy irq controller calls
>> into the irq call paths by reading and replacing the gic irq
>> chip with the new gic arch extensions.
> ...
>> - * Copyright (C) 2010 Google, Inc.
>> + * Copyright (C) 2011 Google, Inc.
>
> Sorry for nitpicking, but should this not be "(C) 2010-2011" instead?
> You don't want to revoke the 2010 rights on the code, do you?

You're right, I'll fix it.
