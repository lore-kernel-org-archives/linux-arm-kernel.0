From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 2 May 2015 10:53:44 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <554347AA.3070502@gmail.com>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150501111406.0aa23c7b@armhf> <554347AA.3070502@gmail.com>
Message-ID: <20150502105344.5b78bd20@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 01 May 2015 11:30:18 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> > I applied the patches 2 and 3, and the audio and video in the Cubox
> > work fine again. Thanks.  
> 
> Ok, good. You mentioned that on v3.19-rc1 it still "works" i.e. despite
> the broken/missing clk_get/clk_prepare_enable?
> 
> Can you check the stable (v3.19, v4.0) versions and see how far we
> should backport the fix?

v3.19 works, v4.0 does not.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
