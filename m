From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 2 Apr 2013 20:23:23 -0300
Subject: [PATCH v2 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
In-Reply-To: <1364907910.2190.37.camel@rzhang1-mobl4>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364292988-8358-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364435017.2275.20.camel@rzhang1-mobl4>
 <20130402013740.GA28373@localhost>
 <1364907910.2190.37.camel@rzhang1-mobl4>
Message-ID: <20130402232322.GB2222@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 09:05:10PM +0800, Zhang Rui wrote:
> On Mon, 2013-04-01 at 22:37 -0300, Ezequiel Garcia wrote:
> > Hi Zhang,
> > 
> > On Thu, Mar 28, 2013 at 09:43:37AM +0800, Zhang Rui wrote:
> > > On Tue, 2013-03-26 at 07:16 -0300, Ezequiel Garcia wrote:
> > > > This driver supports both Armada 370 and Armada XP SoC
> > > > thermal management controllers.
> > > > 
> > > > Armada 370 has a register to check a valid temperature, whereas
> > > > Armada XP does not. Each has a different initialization (i.e. calibration)
> > > > function. The temperature conversion formula is the same for both.
> > > > 
> > > > The controller present in each SoC have a very similar feature set,
> > > > so it corresponds to have one driver to support both of them.
> > > > 
> > > > Although this driver may present similarities to Dove and Kirkwood
> > > > thermal driver, the exact differences and coincidences are not fully
> > > > known. For this reason, support is given through a separate driver.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> patch applied.
> 

Great, thank you! Which branch have you applied this?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
