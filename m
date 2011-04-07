From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 7 Apr 2011 09:27:42 +0200
Subject: [PATCHv5 1/3] ARM: Translate delay.S into (mostly) C
In-Reply-To: <4D9D12FD.6060608@codeaurora.org>
References: <1302047800-26720-1-git-send-email-sboyd@codeaurora.org>	<1302047800-26720-2-git-send-email-sboyd@codeaurora.org>
	<4D9C2910.6020309@stericsson.com> <4D9D12FD.6060608@codeaurora.org>
Message-ID: <4D9D676E.6090608@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2011 03:27 AM, Saravana Kannan wrote:
> Isn't this a big in the existing code too? I would prefer not combining
> that with this patch series. That bug should be fixed before/after this
> patch series. Not as part of it.
>
> I would vote for after this patch series since this patch series has
> been trying to get in for quite a while now.
Ok for me.
Leave it as is and I'll send a patch on top of it.

Yours,
Mattias Wallin
