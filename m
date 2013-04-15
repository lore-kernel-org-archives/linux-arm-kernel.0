From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Apr 2013 10:45:02 +0200
Subject: [PATCH 3/3] ARM: sunxi: unify osc24M_fixed and osc24M
In-Reply-To: <1365515284-32061-4-git-send-email-emilio@elopez.com.ar>
References: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
 <1365515284-32061-4-git-send-email-emilio@elopez.com.ar>
Message-ID: <516BBE0E.2010007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 09/04/2013 15:48, Emilio L?pez a ?crit :
> Now that the clock driver supports the gatable oscillator as one single
> clock, drop osc24M_fixed and move the relevant properties to osc24M
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Rebased and applied in my dt-for-3.10 branch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
