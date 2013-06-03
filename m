From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 3 Jun 2013 07:49:28 +0000
Subject: [PATCH v2 11/14] Documentation: dt: binding: omap: am43x timer
In-Reply-To: <51A60427.6010409@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
 <223d90dc9eeab13d8496690d336cdf0f7d27cd22.1369658705.git.afzal@ti.com>
 <51A520B5.8040803@gmail.com> <51A52A16.1040204@wwwdotorg.org>
 <C8443D0743D26F4388EA172BF4E2A7A93EAFB044@DBDE04.ent.ti.com>
 <51A5BEB6.6070809@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EAFB174@DBDE04.ent.ti.com>
 <51A60427.6010409@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB1238B@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Wed, May 29, 2013 at 19:05:35, Cousson, Benoit wrote:

> And in this case, you do not introduce any new revision.
> 
> There is no point to update the binding each time we add a new SoC
> variant that will contain the exact same IP.
> 
> I think it will mainly confuse the user that will wonder what is
> different in that version compare to the previous one, moreover we can
> end up with hundred of entries for the exact same IP for nothing.
> 
> The real problem is due to the introduction of the SoC name in the
> device compatible name. That does introduced a SoC level information
> that is mostly irrelevant at device level. I can understand why it was
> done for practical aspect when the IP version is not well identified,
> but that can lead to this proliferation of new pointless bindings.

As opinions on $subject seems not yet to be conclusive, I plan to
rebase DTS patch (14/14) over your 'for_3.11/dts' branch (that makes
use of C preprocessor on OMAP DTS) and post separately dropping
11-14 patches, is that okay ?

Regards
Afzal
