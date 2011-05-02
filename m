From: wd@denx.de (Wolfgang Denk)
Date: Mon, 02 May 2011 07:37:35 +0200
Subject: [PATCH 1/4] ARM: tegra: irq: convert to gic arch extensions
In-Reply-To: <1304284213-11950-2-git-send-email-ccross@android.com>
References: <1304284213-11950-1-git-send-email-ccross@android.com>
	<1304284213-11950-2-git-send-email-ccross@android.com>
Message-ID: <20110502053735.68CF01537B0@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Colin Cross,

In message <1304284213-11950-2-git-send-email-ccross@android.com> you wrote:
> Replace the ugly hack that inserts legacy irq controller calls
> into the irq call paths by reading and replacing the gic irq
> chip with the new gic arch extensions.
...
> - * Copyright (C) 2010 Google, Inc.
> + * Copyright (C) 2011 Google, Inc.

Sorry for nitpicking, but should this not be "(C) 2010-2011" instead?
You don't want to revoke the 2010 rights on the code, do you?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
It usually takes more than three weeks to prepare  a  good  impromptu
speech.                                                  - Mark Twain
