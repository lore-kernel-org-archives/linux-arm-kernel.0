From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 28 May 2012 15:34:28 +0530
Subject: [RFC PATCH 08/11] ARM: OMAP4+: Adding the temperature sensor
 register set bit fields
In-Reply-To: <1337934361-1606-9-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-9-git-send-email-eduardo.valentin@ti.com>
Message-ID: <CAMQu2gweS9O7+n3_J=7W3CeDOBgMML+z+BXKafqChhEZd3bmDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> OMAP4460 specific temperature sensor register bit fields are added.
> Existing OMAP4 entries are renamed to OMAP4430.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
Once you split the header, as mentioned in earlier comment,
you can move those defines in driver file directly.

Regards
Santsoh
