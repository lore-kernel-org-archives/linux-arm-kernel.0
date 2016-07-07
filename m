From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 6 Jul 2016 20:50:48 -0700
Subject: [PATCH 1/2] hwspinlock: qcom_hwspinlock: add missing of_node_put
 after calling of_parse_phandle
In-Reply-To: <HE1PR04MB14505D3BC18163C1E4430E918B3B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1467684664-21155-1-git-send-email-peter.chen@nxp.com>
 <20160706193512.GB23833@tuxbot>
 <HE1PR04MB14505D3BC18163C1E4430E918B3B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
Message-ID: <20160707035047.GD23833@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 06 Jul 18:18 PDT 2016, Peter Chen wrote:

>  
> >On Mon 04 Jul 19:11 PDT 2016, Peter Chen wrote:
> >
> >> of_node_put needs to be called when the device node which is got from
> >> of_parse_phandle has finished using.
> >>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-arm-msm at vger.kernel.org
> >> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> >
> >Applied.
> >
> >Please use get_maintainer.pl to find out whom to send patches to, I only stumbled
> >upon this while looking for something else.
> >
> 
> There is no maintainer for this file. Below is the output for get_maintainer.pl:
> 
> $ ./scripts/get_maintainer.pl patch_0705_2/0001-hwspinlock-qcom_hwspinlock-add-missing-of_node_put-a.patch 
> linux-kernel at vger.kernel.org (open list)
> 

That's not good, sorry about that! I sent out a patch including the
other files as well as hwlock related dt bindings.

Regards,
Bjorn
