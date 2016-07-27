From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Jul 2016 10:38:31 +0200
Subject: [PATCH 5/9] clk: sunxi-ng: mux: support fixed pre-dividers on
 multiple parents
In-Reply-To: <1469516671-19377-6-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-6-git-send-email-wens@csie.org>
Message-ID: <20160727103831.2b5c822ecd808deaf8d92707@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2016 15:04:27 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Some clocks on the A31 have fixed pre-dividers on multiple parents.
> Add support for them.

This could be done by intermediate clocks.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
