From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Mar 2011 03:21:29 -0700 (MST)
Subject: [PATCHv2] omap2/3: dmtimer: Enable autoidle
In-Reply-To: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
References: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
Message-ID: <alpine.DEB.2.00.1103100320590.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011, Tero Kristo wrote:

> This saves some power. OMAP4 version should check for GPT module ID, as
> autoidle is only supported on a subset of these.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, queued for 2.6.39 since it looks like these won't be converted to 
hwmod in time for 2.6.39.


- Paul
