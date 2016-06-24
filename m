From: carlo@caione.org (Carlo Caione)
Date: Fri, 24 Jun 2016 23:05:14 +0200
Subject: [PATCH 1/6] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1466339944-602-2-git-send-email-carlo@caione.org>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
 <1466339944-602-2-git-send-email-carlo@caione.org>
Message-ID: <20160624210514.GB5083@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/16 14:38, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Introduce a driver to provide calls into secure monitor mode.
> 
> In the Amlogic SoCs these calls are used for multiple reasons: access to
> NVMEM, set USB boot, enable JTAG, etc...
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Hey Mark,
can you take a look to this patch? Not sure who is supposed to ACK /
review it.

Thanks,

-- 
Carlo Caione
