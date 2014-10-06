From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 06 Oct 2014 11:38:02 +0200
Subject: [PATCH 3/4] [media] Remove optional dependency on PLAT_S5P
In-Reply-To: <54326223.3050201@samsung.com>
References: <1412586626.4054.42.camel@x220> <4788945.SoI4OqN9Zu@wuerfel>
 <54326223.3050201@samsung.com>
Message-ID: <1412588282.4054.51.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-06 at 11:34 +0200, Sylwester Nawrocki wrote:
> On 06/10/14 11:26, Arnd Bergmann wrote:
> > 
> > Does S5PV210 have this device?
> 
> Yes, it does. Indeed, in all patches in this series we should
> have replaced PLAT_S5P with ARCH_S5PV210.

If somebody would actually do that, that would be great. I lost patience
waiting for a patch that did that. So I submitted these cleanup patches
that basically change nothing.


Paul Bolle
