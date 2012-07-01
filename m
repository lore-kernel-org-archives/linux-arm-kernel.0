From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Sun, 01 Jul 2012 13:03:53 +0200
Subject: [PATCH 0/2] MC13xxx: fix access on i.mx31
In-Reply-To: <20120629130945.GK4846@sortiz-mobl>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
 <20120629130945.GK4846@sortiz-mobl>
Message-ID: <2001108.iID9Ml5VFE@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 29 juin 2012 15:09:45 Samuel Ortiz a ?crit :
> Hi Philippe,
> 
> On Tue, May 29, 2012 at 11:06:27AM +0200, Philippe R?tornaz wrote:
> > Hello
> > 
> > This patchset fixes the mc13xxx regression introduced by:
> > "mfd: Use regmap for the mc13xxx-core register access".
> > 
> > The first patch correct the write_flag_mask to use the correct value
> > and remove the invalid bits_per_word in the probe.
> > 
> > The second patch workaround an silicon errata on some imx SoC.
> 
> Both patches applied to my for-linus branch. They'll be part of the MFD
> fixes pull request for 3.5.

Thank you very much ! 

Philippe
