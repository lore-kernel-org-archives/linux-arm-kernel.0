From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 May 2017 09:22:46 -0700
Subject: [PATCH] pinctrl: single: use of_device_get_match_data() to get
 soc data
In-Reply-To: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170522162245.GT10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Masahiro Yamada <yamada.masahiro@socionext.com> [170520 09:06]:
> Use of_device_get_match_data() instead of of_match_device().
> It allows us to remove the forward declaration of pcs_of_match.

That's nice:

Acked-by: Tony Lindgren <tony@atomide.com>
