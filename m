From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 8 Sep 2011 20:58:45 +0200
Subject: [PATCH 11/25] OMAP: Add Secure HAL and monitor mode API
	infrastructure.
In-Reply-To: <1315144466-9395-12-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-12-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAORVsuX5ovK2X8cMGijywAAhOB+ymDze1SzgzVWV2hnZYcswAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On OMAP secure/emulation devices, certain APIs are exported by secure
> code. Add an infrastructure so that relevant operations on secure
> devices can be implemented using it.
>
> While at this, omap44xx-smc.S to omap-smc.S since the common APIs
> can be used on other OMAP's too.
'move' or 'rename' is missing in the sentence.

Regards,
Jean
