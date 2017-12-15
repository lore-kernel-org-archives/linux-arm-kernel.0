From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 19:43:36 -0200
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171215213403.GG7829@linux.vnet.ibm.com>
References: <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
 <20171213091245.GH10595@n2100.armlinux.org.uk>
 <20171215063817.GX7829@linux.vnet.ibm.com>
 <CAOMZO5Cte467YdvOvg_teuKdP435nFd0_t1j6Mxtax43GqMqYw@mail.gmail.com>
 <20171215155218.GB7829@linux.vnet.ibm.com>
 <20171215182340.GA30443@linux.vnet.ibm.com>
 <CAOMZO5C2Mo4VQ2WNDqcXbsu=uP=3suAhPzXd3-LSwbir38A22g@mail.gmail.com>
 <20171215213403.GG7829@linux.vnet.ibm.com>
Message-ID: <CAOMZO5ACh-idu4rharGwBnqzfA+b+29fkvruGMv17WF66h-+UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Dec 15, 2017 at 7:34 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> That would be me being stupid.  Please see below for an updated patch.

This one builds cleanly and works fine on my imx6q board. Thanks
