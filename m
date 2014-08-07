From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Aug 2014 08:55:56 -0300
Subject: [PATCH] ARM: mx6: Fix suspend/resume with PCI
In-Reply-To: <1407405844.4675.9.camel@weser.hi.pengutronix.de>
References: <1407371998-11437-1-git-send-email-festevam@gmail.com>
 <1407405844.4675.9.camel@weser.hi.pengutronix.de>
Message-ID: <CAOMZO5AB+T8d_x-+LqKAVJOCjhbtxOc=VAuWtzc+WVVPb9d7hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 7, 2014 at 7:04 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> Also hiding such things in the platform code seems really bad. Please
> keep in mind that this is the mainline kernel, not a vendor downstream
> tree where you are free to smash things all over the place.

Sure, I should have marked it as RFC. I also asked for a better way to
handle this issue below the --- line.
