From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 20:57:58 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <201203161218.05125.arnd.bergmann@linaro.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
 <201203161218.05125.arnd.bergmann@linaro.org>
Message-ID: <201203162057.58706.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012, Arnd Bergmann wrote:
> > 
> > Can we shoe-horn this thing into 3.4 (it is a bit late, i know) so
> > that platform ports can gather speed? Several people are waiting for a
> > somewhat stable version before starting their ports.
> > 
> > And what is the path into mainline - will Russell carry it or Arnd
> > (with Russell's blessing)?
> 
> I would suggest putting it into a late/* branch of arm-soc so it finally
> gets some linux-next exposure, and then sending it in the second week of the
> merge window.
> 
> Russell, please let me know if you want to carry it instead or if you
> have found any last-minute show stoppers in the code.

FWIW, it's in arm-soc now, and it's the last thing I  put in there
for v3.4. From now on until v3.4-rc1, feature patches can only get
removed from arm-soc, not added.

	Arnd
