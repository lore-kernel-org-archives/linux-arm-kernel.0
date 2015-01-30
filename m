From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 30 Jan 2015 07:02:51 +0200
Subject: [PATCH] arm: reduce conflicts in Kcinfig.debug
In-Reply-To: <20150130130117.4d9fbd70@canb.auug.org.au>
References: <20150130130117.4d9fbd70@canb.auug.org.au>
Message-ID: <20150130050251.GN19448@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Jan 30, 2015 at 01:01:17PM +1100, Stephen Rothwell wrote:
> I have seen several conflicts in this file (and other Kconfig files)
> over time, so I suggest a solution like below.
> 
> Create new config symbols that can be selected by other configs
> and use them as single dependencies rather than having long lists of
> other config symbols as dependencies.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

For subject: s/Kcinfig/Kconfig/

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
