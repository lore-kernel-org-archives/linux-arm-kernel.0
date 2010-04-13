From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 14 Apr 2010 04:18:05 +0800
Subject: [PATCH 1/2] [ARM] pxa: add minimal ULPI functionality for USB
	host port 2 on PXA310.
In-Reply-To: <fa93111b71cf1e43eef23869466072be4db67bcd.1270651775.git.grinberg@compulab.co.il>
References: <cover.1270651775.git.grinberg@compulab.co.il>
	<fa93111b71cf1e43eef23869466072be4db67bcd.1270651775.git.grinberg@compulab.co.il>
Message-ID: <u2nf17812d71004131318z7889c6cdrc0898c62ac1e7622@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 7, 2010 at 11:05 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Include Jing as she's ULPI expert. I myself do not understand the
ULPI well enough.

One general comment though, do we need to make this a dedicated
OTG driver within drivers/usb/otg/? as I know it's OTG capable, but
might be hybrid somehow on pxa310.
