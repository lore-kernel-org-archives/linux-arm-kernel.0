From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Sep 2012 00:00:21 -0300
Subject: [PATCH 4/4] efikamx: remove Efika MX-specific CHRGVBUS hack from
 the USB driver
In-Reply-To: <1343843371-14143-5-git-send-email-matt@genesi-usa.com>
References: <1343843371-14143-1-git-send-email-matt@genesi-usa.com>
 <1343843371-14143-5-git-send-email-matt@genesi-usa.com>
Message-ID: <CAOMZO5CcUZ8NKM6uHkBB1Yo9MjeoBq9NzpOYwT1squM4TOgV7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 2:49 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> Since we're removing Efika MX support from the tree (for now), remove
> the hack present in the USB host driver since it will never run and
> isn't useful on any other systems.
>
> Signed-off-by: Matt Sealey <matt@genesi-usa.com>

You should Cc linux-usb list and the USB maintainer on this one.

Regards,

Fabio Estevam
