From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Jul 2016 13:41:23 -0300
Subject: [PATCH v3 0/6] power: add power sequence library
In-Reply-To: <579A2B38.3000202@gmail.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <579A2B38.3000202@gmail.com>
Message-ID: <CAOMZO5Dv_X-u6qKqAWtysAqmMw91bVoAaRvnc81yUGDxbd27rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

On Thu, Jul 28, 2016 at 12:56 PM, Joshua Clayton
<stillcompiling@gmail.com> wrote:

> I assume there is a v4 coming due to rmk's comments on patch 5.
> I couldn't figure out where to null the of_node in error paths, but in testing
> we did put a line of code to null the of_node on release.
>
> but...
> As an aside,
> I was hoping this series would magically fix a problem
> with the imx6q-evi which has forced us to disable
> runtime power management. But it did not. :(

I also see a similar problem on a mx28 board with a hub.

Does it help in your case if you pass 'usbcore.autosuspend=-1' in the
kernel command line?

Regards,

Fabio Estevam
