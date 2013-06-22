From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Jun 2013 00:47:38 -0300
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <201306220431.50879.marex@denx.de>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <1371849720-14506-2-git-send-email-festevam@gmail.com>
 <201306220431.50879.marex@denx.de>
Message-ID: <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 11:31 PM, Marek Vasut <marex@denx.de> wrote:

> Should the SAIF block reset not happen in the driver?

We need to clear SFTRST and CLKGATE here in order to get MCLK output.
