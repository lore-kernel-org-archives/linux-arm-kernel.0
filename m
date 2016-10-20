From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Oct 2016 06:06:48 -0700
Subject: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
In-Reply-To: <1476805568-19264-12-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-12-git-send-email-t-kristo@ti.com>
Message-ID: <20161020130648.azdsai47atynsdzn@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [161018 08:47]:
> Clockdomains can now be used as clock providers in the system. This
> patch initializes the provider data during init, and parses the clocks
> while they are being registered. An xlate function for the provider
> is also given.

Good to see this happen:

Acked-by: Tony Lindgren <tony@atomide.com>
