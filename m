From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 22 Oct 2015 10:57:45 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151022084735.GR10947@lukather>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151022080508.GN10947@lukather> <20151022102959.09f0a1f4@OPI2>
 <20151022084735.GR10947@lukather>
Message-ID: <20151022105745.2cc158a3@OPI2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015 10:47:35 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Not really. The uart0 reset is the bit 16, in the reset register 4.
> 
> 4 * 32 + 16 = 44.
> 
> Not 112, but still not 208 either.

The registers are numbered 1..5, then

(4 - 1) * 32 + 16 = 112

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
