From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 22:55:04 -0300
Subject: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
In-Reply-To: <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
References: <1403687412-22362-1-git-send-email-b20788@freescale.com>
 <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
Message-ID: <CAOMZO5Cgh61wsZNPjO9JkEr0EwJWeF5A0rN0-yEg32HDkPsguA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 10:23 PM, Fabio Estevam <festevam@gmail.com> wrote:

> With this patch applied I get a flood of these messages:
>
> cpu cpu0: failed to scale vddpu up: -22
> cpufreq: __target_index: Failed to change cpu frequency: -22
> cpu cpu0: failed to scale vddpu up: -22
> cpufreq: __target_index: Failed to change cpu frequency: -22
> cpu cpu0: failed to scale vddpu up: -22
> cpufreq: __target_index: Failed to change cpu frequency: -22
>
> Any suggestions?

Ok, I managed to fix it. Will send the patch soon.
