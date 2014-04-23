From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 23 Apr 2014 14:23:34 +0200
Subject: [PATCH v2 17/38] ARM: orion5x: use node labels for UART and
 SATA on edmini_v2
In-Reply-To: <5357A2BA.1050900@gmail.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-18-git-send-email-thomas.petazzoni@free-electrons.com>
 <5357A2BA.1050900@gmail.com>
Message-ID: <20140423142334.286c57c0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Wed, 23 Apr 2014 13:23:38 +0200, Sebastian Hesselbarth wrote:
> On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> > This commit converts the existing devices described in the edmini_v2
> > Device Tree to use node labels: the UART and SATA device. Also, it
> > reorders the eth and mdio node label references to be sorted
> > alphabetically.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Does this also mean, we agree on the "using node label references" topic
> for Kirkwood?

Well, for Kirkwood I don't know, I'm not the one who has done most of
the Kirkwood conversions.

I continue to have mixed feelings about the usage of node labels. To
me, it breaks the "tree" nature of the Device Tree, by turning it into
just a bunch of &bleh { ... } long list of statements. But this is
purely subjective (just like your opinion, I believe), and I wanted to
move forward with this, so I just did what was necessary :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
