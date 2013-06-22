From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Jun 2013 11:04:41 -0300
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <201306221524.33879.marex@denx.de>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
 <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
 <201306221524.33879.marex@denx.de>
Message-ID: <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:24 AM, Marek Vasut <marex@denx.de> wrote:

> Yuck, I see. This is really ugly :(
>
> Just an idea here, can we not maybe defer the SGTL5000 I2C probe?

This was already discussed in the alsa-devel list, and the
recommendation was that sgtl5000 should acquire its clock in i2c
probe.
