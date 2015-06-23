From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 23 Jun 2015 13:17:12 +0300
Subject: [PATCH 32/41] clocksource: digicolor: Migrate to new 'set-state'
 interface
In-Reply-To: <6809c28328450f138517daa6c22f97f283f3fd01.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <6809c28328450f138517daa6c22f97f283f3fd01.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <20150623101712.GY2303@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Thu, Jun 18, 2015 at 04:24:46PM +0530, Viresh Kumar wrote:
> Migrate digicolor driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested on a Conexant CX92755 Equinox board.

Acked-by: Baruch Siach <baruch@tkos.co.il>
Tested-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
