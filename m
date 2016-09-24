From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 24 Sep 2016 11:11:27 +0200
Subject: [PATCH v3 0/4] regulator: axp20x: support AXP803/AXP813 variants
In-Reply-To: <CAGb2v65LjjB_vM46yurKOcw6mMaxW3pXTHwbxQO6L1BTOnTUmw@mail.gmail.com>
References: <cover.1474621107.git.moinejf@free.fr>
 <CAGb2v65LjjB_vM46yurKOcw6mMaxW3pXTHwbxQO6L1BTOnTUmw@mail.gmail.com>
Message-ID: <20160924111127.942fa9c65db71fa58cf07f18@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Sep 2016 16:35:05 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Fri, Sep 23, 2016 at 4:58 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > This patch series adds support for the X-Powers AXP803 and AXP813 PMICs.
> > It is based on the previous patch series
> >         regulator: axp20x: Simplify various code
> >
> > v3:
> > - put the code of the new devices in new files instead of in the common
> >   axp20x file.
> > - fix errors about the regulators and interrupts
> > v2:
> > - fix lack of support of dcdc frequency
> > - notice that the AXP803 is also handled
> > - send the patch to the DT maintainers
> >
> > Jean-Francois Moine (4):
> >   regulator: axp20x: move device independant parts to new files
> >   regulator: axp20x: duplicate the MFD axp20x-rsb code
> >   regulator: axp20x: add the AXP803
> >   regulator: axp20x: add the AXP813
> 
> NAK. Please follow the axp20x mfd and sub-device driver design we
> already have.

Sorry, I will not: installing a lot of useless code and tables in
permanent system memory for just one regulator is not the way I think
about a good kernel.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
