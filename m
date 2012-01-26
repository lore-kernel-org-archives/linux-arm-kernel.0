From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 26 Jan 2012 15:28:04 +0400
Subject: [PATCH 09/21] OMAP3+: Smartreflex: Fix status masking in ERRCONFIG
 register
In-Reply-To: <1327504583-13408-10-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-10-git-send-email-j-pihet@ti.com>
Message-ID: <4F2138C4.1070506@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> ERRCONFIG register has status bits that were intended not to
> be destroyed by bad modification. We cleanup and simplify the
> handling the status in the modify path.

> Change-Id: I5a7e19fe924a05ffe38c8e31ae8acc48aee8c3f6

    Please remove this line.

> Reported-by: Vincent Bour<v-bour@ti.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>

WBR, Sergei
