From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 19 Oct 2011 15:03:05 +0400
Subject: [PATCH 3/4] ARM: OMAP3: cm-t35: fix audio
In-Reply-To: <1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
	<1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
Message-ID: <4E9EAE69.6010305@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-10-2011 13:39, Igor Grinberg wrote:

> TWL4030 audio codec is not being registered if no platform data is
> supplied. Plovide platform data for the TWL4030 audio codec.

    s/Plovide/Provide/. Perhaps a committer can fix this typo.

> Signed-off-by: Igor Grinberg<grinberg@compulab.co.il>

WBR, Sergei
