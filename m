From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 07 Mar 2014 18:58:26 +0000
Subject: [PATCH v2 4/4] pci: Add support for creating a generic
 host_bridge from device tree
In-Reply-To: <18746655.qWHLpMg2Yy@wuerfel>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com> <
 1393506402-11474-5-git-send-email-Liviu.Dudau@arm.com> <18746655.qWHLpMg2Yy
 @wuerfel>
Message-ID: <20140307185826.0DF50C40D6D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014 14:38:32 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 27 February 2014 13:06:42 Liviu Dudau wrote:
> > Several platforms use a rather generic version of parsing
> > the device tree to find the host bridge ranges. Move the common code
> > into the generic PCI code and use it to create a pci_host_bridge
> > structure that can be used by arch code.
> > 
> > Based on early attempts by Andrew Murray to unify the code.
> > Used powerpc and microblaze PCI code as starting point.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Please add Benjamin Herrenschmidt to Cc here, I think it would be helpful
> to get his input so we can make this work on powerpc as well.

s/helpful/required/

:-)

g.
